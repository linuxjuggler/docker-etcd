# Etcd container

![Publish](https://github.com/linuxjuggler/docker-etcd/workflows/Publish/badge.svg?branch=master) [![Docker Pulls](https://img.shields.io/docker/pulls/zaherg/docker-etcd.svg)](https://hub.docker.com/r/zaherg/docker-etcd/) [![](https://images.microbadger.com/badges/image/zaherg/docker-etcd.svg)](https://microbadger.com/images/zaherg/docker-etcd "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/zaherg/docker-etcd.svg)](https://microbadger.com/images/zaherg/docker-etcd "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/commit/zaherg/docker-etcd.svg)](https://microbadger.com/images/zaherg/docker-etcd "Get your own commit badge on microbadger.com")  [![](https://img.shields.io/github/last-commit/zaherg/docker-etcd.svg)](https://github.com/zaherg/docker-etcd)  [![](https://img.shields.io/badge/sponsor-using%20BTC%20lightning%20network-blue.svg)](https://tippin.me/@zaherg)


![etcd Logo](https://raw.githubusercontent.com/linuxjuggler/docker-etcd/master/images/etcd-horizontal-color.svg?sanitize=true)

etcd is a distributed reliable key-value store for the most critical data of a distributed system, with a focus on being:

* *Simple*: well-defined, user-facing API (gRPC)
* *Secure*: automatic TLS with optional client cert authentication
* *Fast*: benchmarked 10,000 writes/sec
* *Reliable*: properly distributed using Raft

etcd is written in Go and uses the [Raft][raft] consensus algorithm to manage a highly-available replicated log.

etcd is used [in production by many companies](https://github.com/etcd-io/etcd/blob/master/Documentation/production-users.md), and the development team stands behind it in critical deployment scenarios, where etcd is frequently teamed with applications such as [Kubernetes][k8s], [locksmith][locksmith], [vulcand][vulcand], [Doorman][doorman], and many others. Reliability is further ensured by [**rigorous testing**](https://github.com/etcd-io/etcd/tree/master/functional).

See [etcdctl][etcdctl] for a simple command line client.

[raft]: https://raft.github.io/
[k8s]: http://kubernetes.io/
[doorman]: https://github.com/youtube/doorman
[locksmith]: https://github.com/coreos/locksmith
[vulcand]: https://github.com/vulcand/vulcand
[etcdctl]: https://github.com/etcd-io/etcd/tree/master/etcdctl

## Example

You can pass any argument to it as normal:

```sh
docker run \
  -p 2379:2379 \
  -p 2380:2380 \
  --mount type=bind,source=/tmp/etcd-data.tmp,destination=/etcd-data \
  --name etcd \
  zaherg/docker-etcd:latest etcd \
  --name s1 \
  --data-dir /etcd-data \
  --listen-client-urls http://0.0.0.0:2379 \
  --advertise-client-urls http://0.0.0.0:2379 \
  --listen-peer-urls http://0.0.0.0:2380 \
  --initial-advertise-peer-urls http://0.0.0.0:2380 \
  --initial-cluster s1=http://0.0.0.0:2380 \
  --initial-cluster-token tkn \
  --initial-cluster-state new
```

```sh
docker exec etcd sh -c "etcd --version"
docker exec etcd sh -c "ETCDCTL_API=3 etcdctl version"
docker exec etcd sh -c "ETCDCTL_API=3 etcdctl endpoint health"
docker exec etcd sh -c "ETCDCTL_API=3 etcdctl put foo bar"
docker exec etcd sh -c "ETCDCTL_API=3 etcdctl get foo"
```
