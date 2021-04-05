FROM alpine:3.13.4

ARG TARGETPLATFORM

LABEL Maintainer="Zaher Ghaibeh <zaher@zah.me>" \
      org.label-schema.description="Lightweight container with ETCD based on Alpine Linux." \
      org.label-schema.url="https://zaher.dev" \
      org.label-schema.vcs-url="https://github.com/zaherg/docker-etcd.git" \
      org.label-schema.schema-version="1.0.0" \
      org.opencontainers.image.source="https://github.com/zaherg/docker-etcd"

ENV VERSION=3.4.15

RUN apk update && apk upgrade && \
    apk add --no-cache curl ca-certificates openssl tar tini && \
	wget https://github.com/etcd-io/etcd/releases/download/v${VERSION}/etcd-v${VERSION}-$(echo ${TARGETPLATFORM} | sed -e 's/linux\//linux-/g').tar.gz && \
	tar xzvf etcd-v${VERSION}-$(echo ${TARGETPLATFORM} | sed -e 's/linux\//linux-/g').tar.gz && \
	mv etcd-v${VERSION}-$(echo ${TARGETPLATFORM} | sed -e 's/linux\//linux-/g')/etcd* /bin/ && \
	apk del --purge tar openssl && \
    rm -Rf etcd-v${VERSION}-$(echo ${TARGETPLATFORM} | sed -e 's/linux\//linux-/g')*

RUN curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/master/contrib/install.sh | sh -s -- -b /usr/local/bin \
    && trivy filesystem --exit-code 1 --no-progress --light /

VOLUME /etcd-data

EXPOSE 2379 2380

ENTRYPOINT ["/sbin/tini", "--"]

CMD ["etcd"]