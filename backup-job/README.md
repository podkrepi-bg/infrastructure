# Backup job
The backup job defined in this folder is responsible for creating a backup of our PostgreSQL instances and exporting those to GCP Cloud Storage. To achieve this we use a custom container that has gcloud SDK and `pg_dump` and we run it in our cluster using a `CronJob`.

## Prerequisites
In order to deploy the backup job first a Cloud Storage bucked and a service account in GCP need to exist. Currently we have a bucket with 7 days retention period and a service account with Storage Object Create role. It is required that a key is generated for the service account. The key is needed by the job so it can push the backups into the bucket.

## Deployment
To deploy the job in a Kubernetes cluster the following steps need to be performed
1. Create a Kubernetes secret that will hold the GCP service account key
```bash
kubectl create secret generic --from-file=/path/to/creds.json backup-user-gcloud -n podkrepibg
```
2. Create a PostgreSQL user who can read the `podkrepibg` database:
```sql
CREATE USER backup_job WITH ENCRYPTED PASSWORD 'postgrepass';
GRANT CONNECT ON DATABASE "podkrepibg" to backup_job;
ALTER DEFAULT PRIVILEGES IN SCHEMA api GRANT SELECT ON TABLES TO backup_job;
GRANT USAGE ON SCHEMA api TO backup_job;
GRANT SELECT ON ALL TABLES IN SCHEMA api TO backup_job;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA api TO backup_job;
```
3. Create a Kubernetes secret with the PostgreSQL user's password:
```bash
kubectl create secret generic --from-literal=password=postgrepass -n podkrepibg backup-user-postgresql
```
4. Create the `CronJob`:
```bash
kubectl apply -f cronjob.yaml
```

## Releasing the container
To build the container image for the backup job run:
```bash
docker build -t ghcr.io/podkrepi-bg/infrastructure/backup-job:v1 .
```

To push the container image to the repo:
```bash
docker push ghcr.io/podkrepi-bg/infrastructure/backup-job:v1 
```