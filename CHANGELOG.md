# Changelog

## v3.3.2

### Repository

- Migrated repo from `lecaoquochung` to `lehungio`
- Updated all image references to `ghcr.io/lehungio/docker-images`
- Added OCI labels (`org.opencontainers.image.source`, `description`, `licenses`) to all Dockerfiles
- Merged auto-release into release workflow (fixes `GITHUB_TOKEN` trigger limitation)
- Release workflow now triggers on VERSION file change, tag push, and manual release

### Scala Bionic (`scala/build/bionic.Dockerfile`)

- Switched apt repos to `old-releases.ubuntu.com` (Ubuntu 18.04 EOL)
- Replaced deprecated NodeSource setup script with Node.js v16.20.2 binary
- Removed `deadsnakes/ppa`, using Bionic default Python 3.6
- Used archived `get-pip.py` for Python 3.6 support
- Downgraded Playwright to v1.30.0 (last version supporting glibc 2.27)

### PHP Latest (`php/latest.Dockerfile`)

- Replaced stale pinned git commits with `install-php-extensions` v2.11.0
- Removed manual `git clone` of phpredis and xdebug
- Replaced GitHub source refs with standard extension names (imagick, imap, oci8, pdo_oci, redis, xdebug)
- Split Oracle Instant Client packing into separate `RUN` with dynamic `find` paths

### PHP Beta (`php/beta.Dockerfile`)

- Same extension install fixes as PHP latest
- Removed `devscripts` (unresolvable deps on Debian Trixie)
- Removed `apt-transport-https` (built into apt on Trixie)
- Removed `software-properties-common` (unavailable on Debian Trixie)
- Replaced `python3.11` with `python3` (Trixie ships 3.12+)
- Removed duplicate `docker-php-ext-install` calls (already handled by `install-php-extensions`)
- Fixed legacy `ENV key value` format to `ENV key=value`

### Puppeteer (`puppeteer/latest.Dockerfile`)

- Replaced dead Google font URL (`noto-website-2.storage.googleapis.com` returns 403) with `fonts-noto-cjk` apt package
- Fixed legacy `ENV key value` format to `ENV key=value`

### Ubuntu (`ubuntu/latest.Dockerfile`)

- Fixed OCI label syntax and source URL

### Redis (`database/redis/latest.Dockerfile`)

- Fixed source label (was incorrectly pointing to ubuntu Dockerfile)

### Jenkins (`jenkins/latest.Dockerfile`)

- Added OCI labels

## v3.3.1

- Initial release under `lehungio` organization
- CI badge and README updates
