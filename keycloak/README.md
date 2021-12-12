# Keycloak Kubernetes Deployment Manual
We are deploying [Keycloak](https://www.keycloak.org/) on our Rancher cluster using the [bitnami/keycloak](https://bitnami.com/stack/keycloak/helm) Helm chart.

Prerequisites:
 - Have a storage class `rook-ceph-block` configured.

The following settings for the Helm chart are used:
```yaml
---
global:
  storageClass: rook-ceph-block
proxyAddressForwarding: true
service:
  type: ClusterIP
ingress:
  annotations:
    ingress.kubernetes.io/affinity: cookie
    nginx.ingress.kubernetes.io/proxy-buffer-size: 256k
postgresql: 
  persistence: 
    enabled: "true"
```

# Local testing
Run docker-compose up with the docker-compose.yml from this folder. 

# Custom Theme for Podkrepi.bg
The docker-compose.yml will also add a custom theme with the style of Podkprepi.bg from ./theme-podkrepi . 
To make more changes in see tutorial here: https://www.keycloak.org/docs/latest/server_development/#creating-a-theme

