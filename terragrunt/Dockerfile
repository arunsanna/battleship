ARG BASE_REGISTRY=docker.io
ARG BASE_IMAGE=arunsanna/terraform
ARG BASE_TAG=latest

FROM ${BASE_REGISTRY}/${BASE_IMAGE}:${BASE_TAG}

LABEL org.opencontainers.image.source="https://github.com/arunsanna/battleship"
LABEL org.opencontainers.image.description="Terragrunt with Terraform"

USER root

# Updated Terragrunt version with checksum verification
ARG TERRAGRUNT_VERSION=0.55.1
ARG TERRAGRUNT_SHA256=999339e725e4b50ac421502f5ea94e6634e543bc4d8320e8cc7f3c91d5a0d6e8

RUN curl -fsSL "https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_linux_amd64" -o /usr/local/bin/terragrunt && \
    echo "${TERRAGRUNT_SHA256}  /usr/local/bin/terragrunt" | sha256sum -c - && \
    chmod 755 /usr/local/bin/terragrunt && \
    dnf update -y && \
    dnf install -y jq && \
    dnf clean all && \
    rm -rf /var/cache/dnf

USER 1001
WORKDIR /data

HEALTHCHECK NONE

ENTRYPOINT ["terragrunt"]
