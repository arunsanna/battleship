ARG BASE_REGISTRY=docker.io
ARG BASE_IMAGE=arunsanna/terraform
ARG BASE_TAG=latest

FROM ${BASE_REGISTRY}/${BASE_IMAGE}:${BASE_TAG}

USER root

ADD https://github.com/gruntwork-io/terragrunt/releases/download/v0.35.14/terragrunt_linux_amd64 /usr/local/bin/terragrunt

RUN chmod 755 /usr/local/bin/terragrunt && \
    dnf update -y && \
    dnf install -y jq && \
    dnf clean all && \
    rm -rf /var/cache/dnf

USER 1001
WORKDIR /data

HEALTHCHECK NONE

ENTRYPOINT ["terragrunt"]
