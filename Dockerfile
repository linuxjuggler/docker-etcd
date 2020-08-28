FROM alpine:3.12.0

LABEL Maintainer="Zaher Ghaibeh <zaher@zah.me>" \
      org.label-schema.description="Lightweight container with ETCD based on Alpine Linux." \
      org.label-schema.url="https://zaher.dev" \
      org.label-schema.vcs-url="https://github.com/zaherg/docker-etcd.git" \
      org.label-schema.schema-version="1.0.0"

ENV VERSION=3.4.13

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