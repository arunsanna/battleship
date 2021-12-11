ARG BASE_REGISTRY=
ARG BASE_IMAGE=
ARG BASE_TAG=8.5

FROM hashicorp/terraform:1.1.0 as base

FROM ${BASE_REGISTRY}/${BASE_IMAGE}:${BASE_TAG}


COPY --from=base /bin/terraform /bin/terraform

RUN dnf upgrade -y && \
    dnf install -y git openssh && \
    dnf clean all && \
    rm -rf /var/cache/dnf

RUN groupadd -g 1001 terraform && \
    useradd -r -u 1001 -m -s /sbin/nologin -g terraform terraform && \
    chmod g-s /usr/libexec/openssh/ssh-keysign && \
    chown -R terraform:terraform /etc/pki/ca-trust && \
    chmod -R 775 /etc/pki/ca-trust && \    
    rm -f /usr/share/doc/perl-IO-Socket-SSL/example/simulate_proxy.pl && \
    find /usr/share/doc/perl-IO-Socket-SSL/certs -name "*.enc" -o -name "*.pem" | xargs rm -f && \
    find /usr/share/doc/perl-Net-SSLeay/examples -name "*.pem" | xargs rm -f

USER terraform

HEALTHCHECK --interval=30s --timeout=10s \
  CMD curl -f http://localhost:8080/health || exit 1

ENTRYPOINT ["/bin/terraform"]
