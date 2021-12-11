ARG BASE_REGISTRY=docker.io
ARG BASE_IMAGE=arunsnana/terraform
ARG BASE_TAG=latest

FROM ${BASE_REGISTRY}/${BASE_IMAGE}:${BASE_TAG}

USER root
COPY terragrunt /usr/local/bin/terragrunt

RUN chmod 755 /usr/local/bin/terragrunt && \
    dnf update -y && \
    dnf install -y jq && \
    dnf clean all && \
    rm -rf /var/cache/dnf

USER 1001
WORKDIR /data

HEALTHCHECK NONE

ENTRYPOINT ["terragrunt"]
