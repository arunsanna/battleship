ARG BASE_REGISTRY=docker.io
ARG BASE_IMAGE=arunsanna/ubi-8-standard
ARG BASE_TAG=latest

FROM ${BASE_REGISTRY}/${BASE_IMAGE}:${BASE_TAG}
LABEL org.opencontainers.image.authors="sanna.arunchowdary@gmail.com"
LABEL org.opencontainers.image.source="https://github.com/arunsanna/battleship"
LABEL org.opencontainers.image.description="Diagnostics container with cloud tools"

ENV HELM_LATEST_VERSION="v3.14.0" \
    KUBECTL_LATEST_VERSION="v1.29.1" \
    ETCD_VERSION=3.5.11 \
    ETCDCTL_API=3 \
    SHELL=/bin/bash \
    CTOP_VERSION=0.7.7 \
    CALICOCTL_VERSION="v3.27.0" \
    CLOUD_SDK_VERSION=462.0.1 \
    TERM=xterm \
    PATH=${PATH}:/usr/src/diagnostics/google-cloud-sdk/bin:/usr/src/diagnostics/bin \
    TERRAFORM_VERSION="1.7.3" \
    JQ_VERSION="1.7.1"

RUN set -ex && \
    yum update -y && \
    yum install -y python3 \
      findutils \
      net-tools \
      bind-utils \
      iputils \
      curl \
      git \
      unzip \
      vim \
      wget && \
    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/bin && \
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    pip3 install --no-cache-dir awscli && \
    curl -L "https://dl.k8s.io/release/${KUBECTL_LATEST_VERSION}/bin/linux/amd64/kubectl" -o /usr/bin/kubectl && \
    chmod +x /usr/bin/kubectl && \
    curl -L "https://github.com/jqlang/jq/releases/download/jq-${JQ_VERSION}/jq-linux-amd64" -o /usr/bin/jq && \
    chmod +x /usr/bin/jq && \
    wget -q "https://get.helm.sh/helm-${HELM_LATEST_VERSION}-linux-amd64.tar.gz" && \
    tar -xzf helm-${HELM_LATEST_VERSION}-linux-amd64.tar.gz && \
    mv linux-amd64/helm /usr/local/bin/helm && \
    rm -rf linux-amd64 helm-${HELM_LATEST_VERSION}-linux-amd64.tar.gz && \
    wget -q "https://github.com/etcd-io/etcd/releases/download/v${ETCD_VERSION}/etcd-v${ETCD_VERSION}-linux-amd64.tar.gz" && \
    tar zxf etcd-v${ETCD_VERSION}-linux-amd64.tar.gz && \
    cp etcd-v${ETCD_VERSION}-linux-amd64/etcdctl /usr/local/bin/etcdctl && \
    rm -rf etcd-v${ETCD_VERSION}-linux-amd64* && \
    wget -q "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz" && \
    tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    mkdir -p /usr/src/diagnostics && \
    mv google-cloud-sdk /usr/src/diagnostics/ && \
    rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    wget -q "https://github.com/bcicen/ctop/releases/download/v${CTOP_VERSION}/ctop-${CTOP_VERSION}-linux-amd64" -O /usr/local/bin/ctop && \
    chmod +x /usr/local/bin/ctop && \
    curl -sSL -o /usr/local/bin/argocd "https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64" && \
    chmod +x /usr/local/bin/argocd && \
    rm -rf /var/cache/yum && \
    yum clean all

ENTRYPOINT ["tail", "-f", "/dev/null"]


