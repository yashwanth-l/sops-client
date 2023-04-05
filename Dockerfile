FROM alpine:3.17

ARG SOPS_VERSION
ARG VERSION=$SOPS_VERSION

COPY scripts/decrypt-sops \
     scripts/encrypt-sops \
     scripts/decrypt-file-sops \
     scripts/encrypt-file-sops \
     scripts/import-keys \
     /usr/local/bin/

RUN apk update && \
    apk add --no-cache bash gnupg jq curl ca-certificates && \
    mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2 && \
    curl -L https://github.com/mozilla/sops/releases/download/$VERSION/sops-$VERSION.linux -o /usr/local/bin/sops && \
    chmod 0755 /usr/local/bin/sops /usr/local/bin/decrypt-sops /usr/local/bin/decrypt-file-sops /usr/local/bin/encrypt-sops /usr/local/bin/encrypt-file-sops /usr/local/bin/import-keys && \
    chown root:root /usr/local/bin/sops /usr/local/bin/decrypt-sops /usr/local/bin/decrypt-file-sops /usr/local/bin/encrypt-sops /usr/local/bin/encrypt-file-sops /usr/local/bin/import-keys && \
    sops --version && \
    rm -rf /tmp/* /var/cache/apk/*

CMD ["/bin/bash"]