# Keycloak deployment manual
We are deploying [Keycloak](https://www.keycloak.org/) using the [bitnami/keycloak](https://bitnami.com/stack/keycloak/helm) Helm chart.

Prerequisites:
 - Have a storage class `rook-ceph-block` configured.

The following settings for the Helm chart are used:
```yaml
---
global:
  storageClass: rook-ceph-block
service:
  type: ClusterIP
postgresql: 
  persistence: 
    enabled: "true"
```