# ./Dockerfile

FROM node:20-alpine as node-angular-cli

LABEL authors="Arun"
LABEL org.opencontainers.image.source="https://github.com/arunsanna/battleship"
LABEL org.opencontainers.image.description="Node.js with Angular CLI"

# Linux setup
# Install build dependencies and clean up in single layer
RUN apk update \
  && apk add --update alpine-sdk \
  && apk del alpine-sdk \
  && rm -rf /tmp/* /var/cache/apk/* *.tar.gz ~/.npm \
  && npm cache verify \
  && sed -i -e "s/bin\/ash/bin\/sh/" /etc/passwd

# Angular CLI - updated to latest version
RUN npm install -g @angular/cli@17# Trigger build
