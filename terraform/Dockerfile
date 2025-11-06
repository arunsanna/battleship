ARG BASE_REGISTRY=docker.io
ARG BASE_IMAGE=arunsanna/ubi-8-standard
ARG BASE_TAG=latest

FROM hashicorp/terraform:1.7.3 as base

FROM ${BASE_REGISTRY}/${BASE_IMAGE}:${BASE_TAG}

LABEL org.opencontainers.image.source="https://github.com/arunsanna/battleship"
LABEL org.opencontainers.image.description="Terraform CLI container"

COPY --from=base /bin/terraform /bin/terraform

RUN dnf upgrade -y && \
    dnf install -y git openssh && \
    dnf clean all && \
    rm -rf /var/cache/dnf && \
    groupadd -g 1001 terraform && \
    useradd -r -u 1001 -m -s /sbin/nologin -g terraform terraform && \
    chmod g-s /usr/libexec/openssh/ssh-keysign && \
    chown -R terraform:terraform /etc/pki/ca-trust && \
    chmod -R 775 /etc/pki/ca-trust && \
    rm -f /usr/share/doc/perl-IO-Socket-SSL/example/simulate_proxy.pl && \
    find /usr/share/doc/perl-IO-Socket-SSL/certs -name "*.enc" -o -name "*.pem" -delete && \
    find /usr/share/doc/perl-Net-SSLeay/examples -name "*.pem" -delete

USER terraform

# Healthcheck runs terraform version to verify binary is functional
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD ["/bin/terraform", "version"]

ENTRYPOINT ["/bin/terraform"]

# CI test: 2025-11-06T00:25:45Z
