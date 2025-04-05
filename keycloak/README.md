# Keycloak Kubernetes Deployment Manual
We are deploying [Keycloak](https://www.keycloak.org/) on our Rancher cluster using the [bitnami/keycloak](https://bitnami.com/stack/keycloak/helm) Helm chart.

Prerequisites:
 - Have a storage class `rook-ceph-block` configured.

The Helm chart is configured with values for Podkrepi.bg from this file [keycloak-helm-values.yaml](keycloak-helm-values.yaml)

# Local keycloak for development
1. Run docker-compose up with the docker-compose.yml from this folder. The server will start on localhost:9080 with default admin user: user and default password: bitnami as per default configuration from here: https://hub.docker.com/r/bitnami/keycloak/
1. Then you need to create the webapp-dev realm and import the realm settings from this file: https://github.com/podkrepi-bg/api/blob/master/manifests/keycloak-webapp-realm.json . More details about importing a realm file here: https://www.opcito.com/blogs/how-to-import/export-realm-in-keycloak 
1. Redirect the frontend and api projects .env.local to the newly created keycloak, realm and secret. 

More details on configuring the realm here: https://www.keycloak.org/docs/latest/server_admin/#configuring-realms

# Custom Theme for Podkrepi.bg
The docker-compose.yml will also add a custom theme with the style of Podkprepi.bg from ./theme-podkrepi . 
To make more changes in see tutorial here: https://www.keycloak.org/docs/latest/server_development/#creating-a-theme

## Pulling a new version of the custom theme to production
Keycloak caches the template, so a hard reload is needed: 
* For Production: To pull a newer version of the custom theme from the current repo just delete the Keycloak pod from the cluster. A new one will be automatically created and the latest version of the theme will be available there.
* For a local docker: stop&delete the container then run docker-compose up again

# DigitalOcean setup
Create a db user `keycloak` and a database `keycloak` (this should be done in terraform already). Login to the database manually and grant permissions for user `keycloak` to the new database
```sql
GRANT ALL PRIVILEGES ON DATABASE keycloak TO keycloak;
GRANT ALL PRIVILEGES ON SCHEMA public to keycloak;
```

