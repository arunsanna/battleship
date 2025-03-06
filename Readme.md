# Battleship Project

[![ci](https://github.com/arunsanna/battleship/actions/workflows/dockerimage.yml/badge.svg)](https://github.com/arunsanna/battleship/actions/workflows/dockerimage.yml)

## Project Description

This project contains various Dockerfiles and scripts for different configurations and setups. It is organized into multiple folders, each serving a specific purpose.

## Folder Structure

```
- alfa/
- cuda/
- diagnostics/
- kustomize/
- network/
  - build/
- terraform/
- terragrunt/
- ubi-8-fips/
  - nssdb/
  - scripts/
- ubi-8-micro/
  - scripts/
- ubi-8-minimal/
  - scripts/
- ubi-8-standard/
  - scripts/
```

## Installation Instructions

1. Clone the repository:
   ```sh
   git clone https://github.com/arunsanna/battleship.git
   cd battleship
   ```

2. Build the Docker images:
   ```sh
   docker build -t <image-name> -f <Dockerfile-path> .
   ```

## Usage Examples

Run a Docker container:
```sh
   docker run -it <image-name>
```