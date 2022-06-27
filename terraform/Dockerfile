ARG BASE_REGISTRY=docker.io
ARG BASE_IMAGE=arunsanna/ubi-8-standard
ARG BASE_TAG=latest

FROM hashicorp/terraform:1.1.0 as base

FROM ${BASE_REGISTRY}/${BASE_IMAGE}:${BASE_TAG}


COPY --from=base /bin/terraform /bin/terraform

RUN dnf upgrade -y
RUN dnf install -y git openssh
RUN dnf clean all
RUN rm -rf /var/cache/dnf

RUN groupadd -g 1001 terraform
RUN useradd -r -u 1001 -m -s /sbin/nologin -g terraform terraform
RUN chmod g-s /usr/libexec/openssh/ssh-keysign
RUN chown -R terraform:terraform /etc/pki/ca-trust
RUN chmod -R 775 /etc/pki/ca-trust
RUN rm -f /usr/share/doc/perl-IO-Socket-SSL/example/simulate_proxy.pl
RUN find /usr/share/doc/perl-IO-Socket-SSL/certs -name "*.enc" -o -name "*.pem" | xargs rm -f
RUN find /usr/share/doc/perl-Net-SSLeay/examples -name "*.pem" | xargs rm -f

USER terraform

HEALTHCHECK --interval=30s --timeout=10s \
  CMD curl -f http://localhost:8080/health || exit 1

ENTRYPOINT ["/bin/terraform"]
