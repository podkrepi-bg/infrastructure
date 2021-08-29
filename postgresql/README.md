# PostgreSQL deployment manual
We use PostgreSQL for Keycloak*, Ghost* and our own modules. We are deploying it using the [bitnami/postgresql](https://bitnami.com/stack/postgresql/helm) Helm chart.

_* Still to be migrated to use this deployment of PostgreSQL._

Prerequisites:
 - Have a storage class `rook-ceph-block` configured.

 The following settings for the Helm chart are used:
 ```yaml
---
global:
  storageClass: rook-ceph-block
image:
  tag: 13.4.0-debian-10-r16
persistence:
  enabled: true
  size: 15Gi
 ```