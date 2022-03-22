# Ghost deployment manual
We are deploying [Ghost](https://ghost.org/) using the [bitnami/ghost](https://bitnami.com/stack/ghost/helm) Helm chart.

_Note that we currently do not have a storage class for provisioning PVs. The setup described below requires a manual creation and binding of PVCs. This setup will most probably change._

Prerequisites:
 - Have a storage class `rook-ceph-block` configured.

The settings for the Helm chart can be found in `ghost.values.yaml`.

## Updating Ghost settings once it is already deployed
Changing the values of the Helm chart will not update the settings for an already configured Ghost instance. To do that a different approach is required.

1. Copy the `config.production.json` file from the running container to your local machine. For example:
```bash
kubectl cp ghost/ghost-597d75fbf-p7qwr:/bitnami/ghost/config.production.json config.production.json
```
2. Edit the file as you wish.
3. Copy the file back into the running container. For example:
```bash
kubectl cp config.production.json ghost/ghost-597d75fbf-p7qwr:/bitnami/ghost/config.production.json
```
4. Scale down the deployment of ghost to 0.
```bash
kubectl scale -n ghost deployment ghost --replicas=0
```
5. Scale the deployment of ghost to 1 again.
```bash
kubectl scale -n ghost deployment ghost --replicas=1
```