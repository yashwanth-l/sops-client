FROM alpine:3.10.3

ARG SOPS_VERSION
ARG VERSION=$SOPS_VERSION

LABEL maintainer "Yashwanth.Lakkaraju@T-Mobile.com"

COPY scripts/decrypt-sops \
     scripts/import-keys \
     /usr/local/bin/

RUN apk update && \
    apk add --no-cache bash gnupg jq curl ca-certificates && \
    mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2 && \
    curl -L https://github.com/mozilla/sops/releases/download/$VERSION/sops-$VERSION.linux -o /usr/local/bin/sops && \
    chmod 0755 /usr/local/bin/sops && \
    chown root:root /usr/local/bin/sops && \
    sops --version && \
    rm -rf /tmp/* /var/cache/apk/*

CMD ["/bin/bash"]