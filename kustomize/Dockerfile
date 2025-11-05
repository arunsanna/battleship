# Base builder - updated to bookworm
FROM golang:1.21-bookworm as build

LABEL org.opencontainers.image.source="https://github.com/arunsanna/battleship"
LABEL org.opencontainers.image.description="Kustomize with plugins"

ENV GOARCH="amd64"
ENV GOENV="linux"

WORKDIR /plugins

ARG KUSTOMIZE_PLUGIN_PATH=/.config/kustomize/plugin

# --------------------------------------------------------------------------
# Kustomize Generator
# --------------------------------------------------------------------------
# Kustomization - updated to v5.x
ARG KUSTOMIZE_VERSION="5.3.0"
RUN curl -Lo kustomize.tar.gz https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize/v${KUSTOMIZE_VERSION}/kustomize_v${KUSTOMIZE_VERSION}_${GOENV}_${GOARCH}.tar.gz && \
    tar -xzf kustomize.tar.gz && \
    chmod +x kustomize && \
    rm kustomize.tar.gz

# --------------------------------------------------------------------------
# Helm Generator
# --------------------------------------------------------------------------
ARG HELMGENERATOR_NAME="HelmGenerator"
ARG HELMGENERATOR_VERSION="0.2.0"
ARG HELMGENERATOR_URL="https://github.com/joshrwolf/kustomize-helmgenerator/releases/download/v${HELMGENERATOR_VERSION}/${HELMGENERATOR_NAME}_${HELMGENERATOR_VERSION}_${GOENV}_${GOARCH}"

RUN curl -Lo ${HELMGENERATOR_NAME} ${HELMGENERATOR_URL} && \
    chmod +x ${HELMGENERATOR_NAME}

# --------------------------------------------------------------------------
# Sops Generator
# --------------------------------------------------------------------------
ARG SOPSGENERATOR_NAME="SopsSecretGenerator"
ARG SOPSGENERATOR_VERSION="1.3.0"
ARG SOPSGENERATOR_URL="https://github.com/goabout/kustomize-sopssecretgenerator/releases/download/v${SOPSGENERATOR_VERSION}/${SOPSGENERATOR_NAME}_${SOPSGENERATOR_VERSION}_${GOENV}_${GOARCH}"

RUN curl -Lo ${SOPSGENERATOR_NAME} ${SOPSGENERATOR_URL} && \
    chmod +x ${SOPSGENERATOR_NAME}

# Move things into their correct folder

# Copy over to base distroless - updated to debian12
FROM gcr.io/distroless/base-debian12

ENV XDG_CONFIG_HOME=/.config
ENV KUSTOMIZE_PLUGIN_PATH=${XDG_CONFIG_HOME}/kustomize/plugin

# Copy over kustomize
COPY --from=build /plugins/kustomize /kustomize

# Copy over plugins
COPY --from=build /plugins/HelmGenerator ${KUSTOMIZE_PLUGIN_PATH}/p1.dsop.io/v1beta1/helmgenerator/
COPY --from=build /plugins/SopsSecretGenerator ${KUSTOMIZE_PLUGIN_PATH}/goabout.com/v1beta1/sopssecretgenerator/

WORKDIR /app

ENTRYPOINT [ "/kustomize", "build", "--enable_alpha_plugins" ]
