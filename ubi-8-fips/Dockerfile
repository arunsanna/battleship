ARG BASE_REGISTRY=docker.io
ARG BASE_IMAGE=arunsanna/ubi-8-standard
ARG BASE_TAG=latest

FROM ${BASE_REGISTRY}/${BASE_IMAGE}:${BASE_TAG}

COPY scripts /scripts
COPY nssdb/pkcs11.txt /tmp/pkcs11.txt

RUN dnf update -y && \
    /scripts/xccdf_org.ssgproject.content_rule_configure_crypto_policy.sh && \
    /scripts/xccdf_org.ssgproject.content_rule_configure_kerberos_crypto_policy.sh && \
    /scripts/xccdf_org.ssgproject.content_rule_configure_openssl_crypto_policy.sh && \
    cat /tmp/pkcs11.txt >> /etc/pki/nssdb/pkcs11.txt && \
    chown -R root:root /etc/pki/nssdb && \
    chmod 644 /etc/pki/nssdb/* && \
    dnf clean all && \
    rm -rf /var/cache/dnf /scripts /tmp/pkcs11.txt
