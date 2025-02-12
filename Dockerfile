FROM alpine:3.15

ARG IMAGE_VERSION
ARG BUILD_DATE

LABEL org.opencontainers.image.created="$BUILD_DATE"
LABEL org.opencontainers.image.source="github.com/wfg/docker-openvpn-client"
LABEL org.opencontainers.image.version="$IMAGE_VERSION"

ENV KILL_SWITCH=on \
    VPN_LOG_LEVEL=3 \
    HTTP_PROXY=off \
    SOCKS_PROXY=off

RUN apk add --no-cache \
        bash \
        bind-tools \
        dante-server \
        openvpn \
        tinyproxy

RUN mkdir -p /data/vpn

COPY data/ /data

HEALTHCHECK CMD ping -c 3 1.1.1.1 || exit 1

ENTRYPOINT ["/data/scripts/entry.sh"]
