# Ghost deployment manual
We are deploying [Ghost](https://ghost.org/) using the [bitnami/ghost])https://bitnami.com/stack/ghost/helm) Helm chart.

_Note that we currently do not have a storage class for provisioning PVs. The setup described below requires a manual creation and binding of PVCs. This setup will most probably change._

Prerequisites:
 - Have a PVC called `ghost-pvc` for provisioning the storage for Ghost
 - Have a PVC called `ghost-mariadb-pvc` for provisioning the storage for MariaDB

The following settings for the Helm chart are used:
```yaml
---
global:
  storageClass: rook-ceph-block
ghostBlogTitle: Podkrepi.bg
ghostHost: blog.podkrepi.bg
smtpHost: smtp.gmail.com
smtpPort: 465
smtpUser: mail-server@podkrepi.bg
smtpPassword: "m5*M>7&u"
smtpFromAddress: mail-server@podkrepi.bg
smtpService: gmail
persistence: 
  enabled: true
  size: 3Gi
mariadb: 
  primary: 
    persistence: 
      enabled: true
      size: 3Gi
service: 
  type: ClusterIP
```