ARG BASE_REGISTRY=docker.io
ARG BASE_IMAGE=arunsanna/ubi-8-standard
ARG BASE_TAG=latest

FROM ${BASE_REGISTRY}/${BASE_IMAGE}:${BASE_TAG}
LABEL org.opencontainers.image.authors="sanna.arunchowdary@gmail.com"

ENV HELM_LATEST_VERSION="v3.9.0" \
    KUBECTL_LATEST_VERSION="v1.24.2" \
    ETCD_VERSION=3.4.13 \
    ETCDCTL_API=3 \
    RABBIT_VERSION=3.8.14 \
    SHELL=/bin/bash \
    CTOP_VERSION=0.7.5 \
    CALICOCTL_VERSION="v3.18.1" \
    CLOUD_SDK_VERSION=332.0.0 \
    TERM=xterm \
    PATH=${PATH}:/usr/src/diagnostics/google-cloud-sdk/bin:/usr/src/diagnostics/bin \
    TERRAFORM_VERSION="1.2.3"
    
RUN set -ex \ 
    yum update -y \
    yum install -y python3 \
      findutils \
      net-tools \
      bind-utils \
      iputils \
      curl \
      git \
      unzip \
      vim \
      wget \
    && wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/bin \
    && pip3 install awscli \
	  # && curl -L https://storage.googleapis.com/kubernetes-release/release/latest/bin/linux/amd64/kubectl -o /usr/bin/kubectl && chmod +x /usr/bin/kubectl && \
	  # && curl -L https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 -o /usr/bin/jq && chmod +x /usr/bin/jq \
    # && wget -q https://get.helm.sh/helm-${HELM_LATEST_VERSION}-linux-amd64.tar.gz \
    # && tar -xvf helm-${HELM_LATEST_VERSION}-linux-amd64.tar.gz \
    # && mv linux-amd64/helm /usr/local/bin \
    # && wget -q https://github.com/coreos/etcd/releases/download/v${ETCD_VERSION}/etcd-v${ETCD_VERSION}-linux-amd64.tar.gz \
    # && tar zxvf etcd-v${ETCD_VERSION}-linux-amd64.tar.gz \
    # && cp etcd-v${ETCD_VERSION}-linux-amd64/etcdctl /usr/local/bin/etcdctl \
    # && wget -q https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz \
    # && tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz \
    # && mv google-cloud-sdk /usr/src/diagnostics/ \
    # && wget -q https://github.com/bcicen/ctop/releases/download/v${CTOP_VERSION}/ctop-${CTOP_VERSION}-linux-amd64 -O /usr/local/bin/ctop \
    # && curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64 \
    # && chmod +x /usr/local/bin/argocd \
    # && curl -s https://fluxcd.io/install.sh | sudo bash \
    # && curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash \
    && rm -rf /var/cache/yum \
    && yum clean all


ENTRYPOINT ["tail", "-f", "/dev/null"]


