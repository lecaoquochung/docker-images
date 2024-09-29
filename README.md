# Docker Images CI

This repository contains Docker images for various environments including Ubuntu, PHP, Scala, and Jenkins. The images are automatically built and tagged using GitHub Actions upon every push or pull request to the `main` branch.

## Table of Contents

- [Build Configuration](#build-configuration)
- [Images](#images)
  - [Ubuntu](#ubuntu)
  - [PHP](#php)
  - [Scala](#scala)
  - [Jenkins](#jenkins)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Build Configuration

The Docker images are built using the following configuration:

- **Trigger**: Builds are triggered on push or pull request to the `main` branch.
- **CI Workflow**: The build process is defined in the GitHub Actions workflow file (`.github/workflows/ci.yml`).

### Jobs

The CI workflow includes several jobs to build Docker images for different environments:

- **OS Ubuntu**
  - `build-ubuntu-latest`: Builds the latest Ubuntu image.
  - `build-ubuntu-qa`: Builds the QA version of the Ubuntu image.
  - `build-ubuntu-noble`: Builds the Noble version of the Ubuntu image.

- **PHP**
  - `build-php-latest`: Builds the latest PHP image.
  - `build-php-beta`: Builds the Beta version of the PHP image.

- **Scala**
  - `build-scala-bionic`: Builds the Bionic version of the Scala image.
  - `build-scala-mantic`: Builds the Mantic version of the Scala image.

- **Jenkins**
  - `build-jenkins-latest`: Builds the latest Jenkins image.

Each job checks out the repository, builds the Docker image using the specified Dockerfile, and tags the image with the current timestamp.

## Images

### Ubuntu

- `ubuntu-latest`: The latest version of Ubuntu.
- `ubuntu-qa`: The QA version of Ubuntu.
- `ubuntu-noble`: The Noble version of Ubuntu.

### PHP

- `php:latest`: The latest PHP-FPM image.
- `php:beta`: The Beta version of PHP-FPM.

### Scala

- `scala-bionic`: Scala image based on the Bionic version.
- `scala-mantic`: Scala image based on the Mantic version.

### Jenkins

- `jenkins-latest`: The latest Jenkins image.

## Usage

You can use these Docker images in your own projects by pulling them from your container registry (after pushing the images to a registry, if applicable). Replace `<image_name>` with the appropriate image tag.

```bash
docker pull <image_name>:<tag>
