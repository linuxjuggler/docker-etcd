# Etcd container


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