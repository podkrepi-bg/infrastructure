# Rook-Ceph deployment
Podkrepi.bg uses Ceph for provisioning persistent volumes and serving a S3 interface. [Rook](rook.io) is used to help deploying and configuring Ceph. The steps for deploying Rook-Ceph are described below.

Prerequisites:
```bash
kubectl create -f https://raw.githubusercontent.com/rook/rook/v1.6.6/cluster/examples/kubernetes/ceph/crds.yaml
kubectl create -f https://raw.githubusercontent.com/rook/rook/v1.6.6/cluster/examples/kubernetes/ceph/common.yaml
kubectl create -f https://raw.githubusercontent.com/rook/rook/v1.6.6/cluster/examples/kubernetes/ceph/operator.yaml
```

## Ceph cluster
The current Ceph cluster is deployed on a single disk - `sdb` on each worker node of the cluster.

_Note that this might have to be revised in the future if we want to scale up._

To deploy the Ceph cluster, run:
```bash
kubectl create -f cluster.yaml
```

The command will configure the cluster with single device used from each worker node. It will also deploy the Ceph dashboard, which will be running behind the service `rook-ceph-mgr-dashboard`. The password for the admin user of the dashboard can be found in the `rook-ceph-dashboard-password` secret.