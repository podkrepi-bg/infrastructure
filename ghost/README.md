# Ghost deployment manual
We are deploying [Ghost](https://ghost.org/) using the [bitnami/ghost](https://bitnami.com/stack/ghost/helm) Helm chart.

_Note that we currently do not have a storage class for provisioning PVs. The setup described below requires a manual creation and binding of PVCs. This setup will most probably change._

Prerequisites:
 - Have a storage class `rook-ceph-block` configured.

The settings for the Helm chart can be found in `ghost.values.yaml`.