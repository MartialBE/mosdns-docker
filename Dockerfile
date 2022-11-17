FROM --platform=${TARGETPLATFORM} golang:alpine as builder
ARG CGO_ENABLED=0
ARG TAG
ARG REPOSITORY

WORKDIR /root
RUN apk add --update git \
    && git clone https://github.com/${REPOSITORY} mosdns \
    && cd ./mosdns \
    && git fetch --all --tags \
    && git checkout tags/${TAG} \
	&& go build -ldflags "-s -w -X main.version=${TAG}" -trimpath -o mosdns

FROM --platform=${TARGETPLATFORM} alpine:latest
LABEL maintainer="MartialBE"

ENV TZ Asia/Shanghai
ENV GEOIP https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat
ENV GEOSITE https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat

COPY --from=builder /root/mosdns/mosdns /usr/bin/

RUN apk update --no-cache && \
    apk upgrade --no-cache && \
    apk add --no-cache tzdata ca-certificates


ADD entrypoint.sh /root
ADD update_geodat.sh /root
ADD config.yaml /root

RUN wget $GEOIP -O /root/geoip.dat && \
    wget $GEOSITE -O /root/geosite.dat && \
    chmod a+x /root/entrypoint.sh && \
    chmod a+x /root/update_geodat.sh && \
    echo '0 2 * * *  /root/update_geodat.sh'>>/var/spool/cron/crontabs/root

VOLUME /etc/mosdns
WORKDIR /etc/mosdns

EXPOSE 53/udp 
EXPOSE 53/tcp
EXPOSE 8338/tcp

HEALTHCHECK --interval=10s --timeout=3s CMD nslookup -querytype=A www.baidu.com 127.0.0.1 | sed -n '6,7p' || exit 1

ENTRYPOINT ["/root/entrypoint.sh"]