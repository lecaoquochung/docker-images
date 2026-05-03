[![CircleCI](https://dl.circleci.com/status-badge/img/gh/lehungio/docker-images/tree/main.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/lehungio/docker-images/tree/main)
![Github Actions](https://github.com/lehungio/docker-images/actions/workflows/release.yml/badge.svg)

# Docker Images CI

This repository contains Docker images for various environments including Ubuntu, PHP, Scala, Puppeteer, Redis, and Jenkins. Images are automatically built via GitHub Actions and CircleCI.

## Table of Contents

- [Workflows](#workflows)
  - [Release](#release)
  - [CI](#ci)
  - [Automation](#automation)
  - [Coding](#coding)
- [Images](#images)
  - [Ubuntu](#ubuntu)
  - [PHP](#php)
  - [Scala](#scala)
  - [Puppeteer](#puppeteer)
  - [Redis](#redis)
  - [Jenkins](#jenkins)
- [Usage](#usage)
- [License](#license)

## Workflows

### Release

Defined in `.github/workflows/release.yml`. Triggered on **GitHub Release published**. Builds and pushes images to `ghcr.io/lehungio/docker-images`.

| Job | Dockerfile | Tags |
|---|---|---|
| `release-ubuntu-latest` | `./ubuntu/latest.Dockerfile` | `ubuntu-latest-v3.3.1`, `ubuntu-latest-sha-<short>` |
| `release-php-latest` | `./php/latest.Dockerfile` | `php-latest-v3.3.1`, `php-latest-sha-<short>` |
| `release-php-beta` | `./php/beta.Dockerfile` | `php-beta-v3.3.1`, `php-beta-sha-<short>` |
| `release-redis-latest` | `./database/redis/latest.Dockerfile` | `redis-latest-v3.3.1`, `redis-latest-sha-<short>` |
| `release-puppeteer-latest` | `./puppeteer/latest.Dockerfile` | `puppeteer-latest`, `puppeteer-latest-v3.3.1` |

### CI

Defined in `.github/workflows/ci.yml`. Triggered on push to `ci`, `dev`, `build*`, `implementation*` branches.

- Manual build jobs (build-only, no push): Ubuntu, PHP, Scala (bionic, latest, maintenance), Jenkins, Puppeteer, Redis, macOS, Windows
- Automation build jobs (build and push): Ubuntu, PHP (latest + beta), Puppeteer, Redis
- Test jobs: Postman, Newman, Redash, Scala coding, Redis connection

### Automation

Defined in `.github/workflows/automation.yml`. Runs weekly (Monday 5:00 AM JST) and on manual dispatch. Build-only (no push) for: Ubuntu (latest, QA, Noble), PHP, Scala (bionic, maintenance), Jenkins.

### Coding

Defined in `.github/workflows/coding.yml`. Triggered on push to `coding*`, `prog*`, `test*` branches. Runs Scala and TypeScript test suites.

## Images

### Ubuntu

| Image | Dockerfile | Base |
|---|---|---|
| `ubuntu-latest` | `./ubuntu/latest.Dockerfile` | `ubuntu:latest` |
| `ubuntu-qa` | `./ubuntu/qa.Dockerfile` | Ubuntu QA |
| `ubuntu-noble` | `./ubuntu/noble.Dockerfile` | `ubuntu:noble` |

### PHP

| Image | Dockerfile | Base | PHP | Node |
|---|---|---|---|---|
| `php-latest` | `./php/latest.Dockerfile` | `php:8.3.7-fpm` | 8.3.7 | LTS (via nvm) |
| `php-beta` | `./php/beta.Dockerfile` | `php:8.4-fpm` | 8.4 | LTS (via nvm) |

### Scala

| Image | Dockerfile | Base | Java | sbt | Node | Playwright | Notes |
|---|---|---|---|---|---|---|---|
| `scala-latest` | `./scala/build/latest.Dockerfile` | `ubuntu:24.10` | 11 | 1.10.2 | 22.9.0 | 1.47.2 | |
| `scala-bionic` | `./scala/build/bionic.Dockerfile` | `ubuntu:bionic` | 8 | 1.2.8 | 16.20.2 | 1.30.0 | EOL — uses archive repos |
| `scala-maintenance` | `./scala/build/maintenance.Dockerfile` | `ubuntu:24.04` | 11 | 1.10.2 | 20.x | 1.47.2 | |
| `scala-mantic` | — | — | — | — | — | — | Deprecated (v2024.4.1) |

### Puppeteer

| Image | Dockerfile | Base | Node | Chrome |
|---|---|---|---|---|
| `puppeteer-latest` | `./puppeteer/latest.Dockerfile` | `node:23.8.0` | 23.8.0 | google-chrome-stable |

### Redis

| Image | Dockerfile | Base |
|---|---|---|
| `redis-latest` | `./database/redis/latest.Dockerfile` | `redis:latest` |

### Jenkins

| Image | Dockerfile | Base |
|---|---|---|
| `jenkins-latest` | `./jenkins/latest.Dockerfile` | `jenkins/jenkins:latest` |

## Usage

Pull images from GitHub Container Registry:

```bash
docker pull ghcr.io/lehungio/docker-images:<tag>
```

Examples:

```bash
# Release images (stable)
docker pull ghcr.io/lehungio/docker-images:ubuntu-latest-v3.3.1
docker pull ghcr.io/lehungio/docker-images:php-latest-v3.3.1
docker pull ghcr.io/lehungio/docker-images:puppeteer-latest-v3.3.1
docker pull ghcr.io/lehungio/docker-images:redis-latest-v3.3.1

# Rolling latest (puppeteer only)
docker pull ghcr.io/lehungio/docker-images:puppeteer-latest
```

## License

See [LICENSE](LICENSE).
