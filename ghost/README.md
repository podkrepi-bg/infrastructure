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

# Backing up ghost
To backup ghost it is required to backup all the static data inside the ghost pod. You can do that by running:
```bash
kubectl cp ghost2/ghost-19-1669648135-7dd549f897-bpscr:/bitnami/ghost/content/ content/ 
```

```bash
tar -cvf archive.tar -h content/
```

It may be needed to archive the theme separately from the `content/themes` folder and upload it via the Ghost UI.

# DigitalOcean setup
All the steps required to run Ghost inside DigitalOcean cluster are listed below.

## Database setup
Create a db user `ghost` and a database `ghost` (this should be done in terraform already). Login to the database manually and grant permissions for user `ghost` to the new database
```sql
GRANT ALL PRIVILEGES ON ghost.* TO ghost;
FLUSH PRIVILEGES;
```

## SSL setup
It is required to have SSL configured on the Digital Ocean load balancer so we can proxy it via Cloudflare. To do that we need a certificate for the domain. Such certificate can be generated via `certbot`:
```
sudo certbot certonly --manual --preferred-challenges dns -d www.blog-do.podkrepi.bg -d blog-do.podkrepi.bg
```

The files need to be copied inside the terraform folder:
```
sudo cp /etc/letsencrypt/live/www.blog-do.podkrepi.bg/privkey.pem .
sudo cp /etc/letsencrypt/live/www.blog-do.podkrepi.bg/chain.pem .
sudo cp /etc/letsencrypt/live/www.blog-do.podkrepi.bg/cert.pem .
```