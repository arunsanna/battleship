# Battleship - Enterprise Container Catalog

[![ci](https://github.com/arunsanna/battleship/actions/workflows/dockerimage.yml/badge.svg)](https://github.com/arunsanna/battleship/actions/workflows/dockerimage.yml)

## Overview

Battleship is a curated collection of production-ready container images designed for modern cloud-native development, infrastructure automation, and enterprise security compliance. Each container is purpose-built with specific tools and configurations to support DevOps, SRE, and security workflows.

## Container Catalog

### 🚀 Development & Build Tools

#### alfa/
**Node.js with Angular CLI**
- **Base Image:** `node:20-alpine`
- **Version:** Angular CLI 17
- **Use Case:** Angular application development and builds
- **Size:** Optimized Alpine-based image
- **Build:**
  ```bash
  cd alfa && docker build -t battleship-alfa:latest .
  ```

#### kustomize/
**Kustomize with Plugins**
- **Base Image:** `gcr.io/distroless/base-debian12`
- **Includes:**
  - Kustomize v5.3.0
  - HelmGenerator plugin v0.2.0
  - SopsSecretGenerator plugin v1.3.0
- **Use Case:** Kubernetes manifests customization with Helm and SOPS integration
- **Build:**
  ```bash
  cd kustomize && docker build -t battleship-kustomize:latest .
  ```

### 🛠️ Infrastructure as Code

#### terraform/
**Terraform CLI**
- **Base Image:** `arunsanna/ubi-8-standard`
- **Version:** Terraform 1.7.3
- **Features:**
  - Non-root user execution
  - Git and SSH support
  - Health checks enabled
  - DISA STIG compliant base
- **Build:**
  ```bash
  cd terraform && docker build -t battleship-terraform:latest .
  ```
- **Usage:**
  ```bash
  docker run -it -v $(pwd):/workspace battleship-terraform:latest plan
  ```

#### terragrunt/
**Terragrunt with Terraform**
- **Base Image:** `arunsanna/terraform:latest`
- **Version:** Terragrunt 0.55.1
- **Features:**
  - SHA256 checksum verification
  - jq for JSON processing
  - Built on RHEL-based UBI
- **Build:**
  ```bash
  cd terragrunt && docker build -t battleship-terragrunt:latest .
  ```

### 🔍 Diagnostics & Troubleshooting

#### diagnostics/
**Cloud Diagnostics Toolkit**
- **Base Image:** `arunsanna/ubi-8-standard`
- **Includes:**
  - Kubernetes: kubectl v1.29.1
  - Helm v3.14.0
  - Terraform v1.7.3
  - AWS CLI (latest)
  - Google Cloud SDK v462.0.1
  - etcdctl v3.5.11
  - ArgoCD CLI (latest)
  - ctop v0.7.7
  - jq v1.7.1
- **Use Case:** Multi-cloud debugging and cluster diagnostics
- **Build:**
  ```bash
  cd diagnostics && docker build -t battleship-diagnostics:latest .
  ```
- **Usage:**
  ```bash
  docker run -it --network host battleship-diagnostics:latest
  ```

#### network/
**Network Troubleshooting Suite**
- **Base Image:** `alpine:3.19`
- **Includes:**
  - Network: tcpdump, tshark, nmap, mtr, iperf, netcat
  - DNS: bind-tools, drill
  - HTTP: curl, httpie, apache2-utils
  - Kubernetes: calicoctl (latest)
  - Monitoring: ctop, termshark, iftop
  - Shell: zsh with oh-my-zsh, powerlevel10k theme
- **Use Case:** Kubernetes network debugging, packet analysis
- **Build:**
  ```bash
  cd network && docker build -t battleship-network:latest .
  ```
- **Usage:**
  ```bash
  kubectl run netshoot --rm -it --image=battleship-network:latest
  ```
- **Notes:** ARM64 compatible (ctop gracefully skipped on ARM)

### 🔒 Security & Compliance

#### ubi-8-standard/
**Red Hat UBI 8 Standard**
- **Base Image:** `registry.access.redhat.com/ubi8/ubi:8.9`
- **Features:**
  - DISA STIG hardening scripts
  - FIPS crypto-policies
  - Audit daemon
  - SELinux enabled
  - CA trust management
- **Use Case:** Baseline for enterprise compliant containers
- **Build:**
  ```bash
  cd ubi-8-standard && docker build -t battleship-ubi-8-standard:latest .
  ```

#### ubi-8-minimal/
**Red Hat UBI 8 Minimal**
- **Base Image:** `registry.access.redhat.com/ubi8/ubi-minimal:8.9`
- **Features:**
  - Minimal footprint (~40MB smaller)
  - STIG hardening included
  - microdnf package manager
- **Use Case:** Lightweight compliant base images
- **Build:**
  ```bash
  cd ubi-8-minimal && docker build -t battleship-ubi-8-minimal:latest .
  ```

#### ubi-8-micro/
**Red Hat UBI 8 Micro**
- **Base Image:** `registry.access.redhat.com/ubi8/ubi-micro:8.9`
- **Features:**
  - Ultra-minimal (~80MB)
  - No package manager (immutable)
  - STIG compliant
- **Use Case:** Distroless-style secure containers
- **Build:**
  ```bash
  cd ubi-8-micro && docker build -t battleship-ubi-8-micro:latest .
  ```

#### ubi-8-fips/
**Red Hat UBI 8 FIPS Mode**
- **Base Image:** `registry.access.redhat.com/ubi8/ubi:8.9`
- **Features:**
  - FIPS 140-2 cryptographic modules
  - NSS database configuration
  - STIG hardening
  - Audit logging
- **Use Case:** Government/DoD compliant workloads
- **Build:**
  ```bash
  cd ubi-8-fips && docker build -t battleship-ubi-8-fips:latest .
  ```

### 🎮 GPU & Edge Computing

#### cuda/
**K3s with NVIDIA CUDA**
- **Base Image:** `nvidia/cuda:12.3.1-base-ubuntu22.04`
- **Features:**
  - K3s v1.28.5-k3s1
  - NVIDIA Container Toolkit
  - GPU device plugin daemonset
  - Containerd runtime configuration
- **Use Case:** Lightweight Kubernetes with GPU support
- **Build:**
  ```bash
  cd cuda && docker build -t battleship-cuda:latest .
  ```
- **Usage:**
  ```bash
  docker run --gpus all -it battleship-cuda:latest server
  ```

## Quick Start

### Clone Repository
```bash
git clone https://github.com/arunsanna/battleship.git
cd battleship
```

### Build All Images
```bash
# Build specific image
cd <container-name>
docker build -t battleship-<container-name>:latest .

# Example: Build diagnostics container
cd diagnostics
docker build -t battleship-diagnostics:latest .
```

### Pull from GitHub Container Registry
```bash
docker pull ghcr.io/arunsanna/battleship/<container-name>:latest
```

## Architecture Support

All containers are built and tested for:
- ✅ **AMD64** (x86_64)
- ✅ **ARM64** (Apple Silicon, ARM servers)

### ARM64 Notes
- **network/**: ctop binary unavailable on ARM64, gracefully skipped
- **diagnostics/**: All tools ARM64 compatible
- All other containers: Full ARM64 support

## CI/CD Pipeline

Automated builds triggered on:
- Push to `main` or `develop` branches
- Path-based triggers (only affected containers rebuild)
- Manual workflow dispatch

**Workflows:**
- `.github/workflows/dockerimage.yml` - Multi-stage Docker builds
- Automated testing for all platforms
- Push to GitHub Container Registry (ghcr.io)

## Security Features

### DISA STIG Compliance
All UBI-based containers include:
- Password policies
- Audit configurations
- Secure crypto policies
- Permission hardening
- Minimal attack surface

### Best Practices
- Non-root users where applicable
- Multi-stage builds for smaller images
- SHA256 verification for binaries
- Regular base image updates
- Health checks enabled

## Contributing

1. Fork the repository
2. Create feature branch
3. Test builds locally (AMD64 + ARM64)
4. Submit PR with updated documentation

## License

See [LICENSE](LICENSE) file for details.

## Maintainer

**Arun Sanna**
- GitHub: [@arunsanna](https://github.com/arunsanna)
- Email: sanna.arunchowdary@gmail.com

## Changelog

### Latest Updates
- ✅ All 11 containers tested on ARM64 (macOS)
- 🔧 Fixed network container Alpine version (3.13→3.19)
- 🔒 Updated Terragrunt SHA256 checksum
- 🎮 Fixed CUDA K3s multi-stage build
- 📦 Updated all tool versions to latest stable
# build trigger: 2025-11-06T01:23:37Z
