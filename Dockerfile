FROM alpine:3.9

ARG BUILD_DATE
ARG VCS_REF
ARG IMAGE_NAME
ARG DOCKER_REPO
ENV COMPOSER_ALLOW_SUPERUSER 1

LABEL Maintainer="Mhd Zaher Ghaibeh <z@zah.me>" \
      org.label-schema.name="$DOCKER_REPO:latest" \
      org.label-schema.description="Lightweight container with ETCD based on Alpine Linux." \
      org.label-schema.url="https://www.zah.me" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/linuxjuggler/docker-etcd.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.schema-version="1.0.0"

ENV VERSION=3.3.13

RUN apk add --no-cache ca-certificates openssl tar tini && \
	wget https://github.com/etcd-io/etcd/releases/download/v$VERSION/etcd-v$VERSION-linux-amd64.tar.gz && \
	tar xzvf etcd-v$VERSION-linux-amd64.tar.gz && \
	mv etcd-v$VERSION-linux-amd64/etcd* /bin/ && \
	apk del --purge tar openssl && \
    rm -Rf etcd-v$VERSION-linux-amd64*


VOLUME /etcd-data

EXPOSE 2379 2380

ENTRYPOINT ["/sbin/tini", "--"]

CMD ["etcd"]