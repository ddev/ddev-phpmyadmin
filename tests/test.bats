setup() {
  set -eu -o pipefail
  brew_prefix=$(brew --prefix)
  load "${brew_prefix}/lib/bats-support/load.bash"
  load "${brew_prefix}/lib/bats-assert/load.bash"

  export DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )/.."
  export TESTDIR=~/tmp/test-phpmyadmin
  mkdir -p $TESTDIR
  export PROJNAME=test-phpmyadmin
  export DDEV_NON_INTERACTIVE=true
  ddev delete -Oy ${PROJNAME} >/dev/null 2>&1 || true
  cd "${TESTDIR}"
  ddev config --project-name=${PROJNAME}
  ddev config --omit-containers=dba >/dev/null 2>&1 || true
  ddev start -y >/dev/null 2>&1
}

health_checks() {
  set +u # bats-assert has unset variables so turn off unset check
  # Make sure we can hit the 8037 port successfully
  curl -s -I -f  https://${PROJNAME}.ddev.site:8037 >/tmp/curlout.txt
  # Make sure `ddev phpmyadmin` works
  DDEV_DEBUG=true run ddev phpmyadmin
  assert_success
  assert_output "FULLURL https://${PROJNAME}.ddev.site:8037"
}

teardown() {
  set -eu -o pipefail
  cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  ddev delete -Oy ${PROJNAME} >/dev/null 2>&1
  [ "${TESTDIR}" != "" ] && rm -rf ${TESTDIR}
}

@test "install from directory" {
  set -eu -o pipefail
  cd ${TESTDIR}
  echo "# ddev get ${DIR} with project ${PROJNAME} in ${TESTDIR} ($(pwd))" >&3
  ddev get ${DIR} >/dev/null 2>&1
  ddev mutagen sync >/dev/null 2>&1
  health_checks
}

@test "install from release" {
  set -eu -o pipefail
  cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  echo "# ddev get ddev/ddev-phpmyadmin with project ${PROJNAME} in ${TESTDIR} ($(pwd))" >&3
  ddev get ddev/ddev-phpmyadmin >/dev/null 2>&1
  ddev restart >/dev/null 2>&1
  health_checks
}

