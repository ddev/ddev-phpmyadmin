[![tests](https://github.com/ddev/ddev-phpmyadmin/actions/workflows/tests.yml/badge.svg?branch=main)](https://github.com/ddev/ddev-phpmyadmin/actions/workflows/tests.yml?query=branch%3Amain)
[![last commit](https://img.shields.io/github/last-commit/ddev/ddev-phpmyadmin)](https://github.com/ddev/ddev-phpmyadmin/commits)
[![release](https://img.shields.io/github/v/release/ddev/ddev-phpmyadmin)](https://github.com/ddev/ddev-phpmyadmin/releases/latest)

# DDEV phpMyAdmin

## Overview

[phpMyAdmin](https://www.phpmyadmin.net/) is a free and open source administration tool for MySQL and MariaDB.

This add-on integrates phpMyAdmin into your [DDEV](https://ddev.com/) project.

## Installation

```bash
ddev add-on get ddev/ddev-phpmyadmin
ddev restart
```

After installation, make sure to commit the `.ddev` directory to version control.

## Usage

| Command | Description |
| ------- | ----------- |
| `ddev phpmyadmin` | Open phpMyAdmin in your browser (`https://<project>.ddev.site:8037`) |
| `ddev describe` | View service status and used ports for phpMyAdmin |
| `ddev logs -s phpmyadmin` | Check phpMyAdmin logs |

## Advanced Customization

To change the Docker image:

```sh
ddev dotenv set .ddev/.env.phpmyadmin --phpmyadmin-docker-image=phpmyadmin:5
ddev add-on get ddev/ddev-phpmyadmin
ddev restart
```

Make sure to commit the `.ddev/.env.phpmyadmin` file to version control.

All customization options (use with caution):

| Variable | Flag | Default |
| -------- | ---- | ------- |
| `PHPMYADMIN_DOCKER_IMAGE` | `--phpmyadmin-docker-image` | `phpmyadmin:5` |

## Credits

**Contributed by [@rfay](https://github.com/rfay)**

**Maintained by the [DDEV team](https://ddev.com/support-ddev/)**
