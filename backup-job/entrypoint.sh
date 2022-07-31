#!/bin/bash
set -e

NOW=`date +%Y%m%d-%H%M%S`
PG_BACKUP_PATH=/var/podkrepibg-backup-$NOW.sql

# Do the backup
pg_dump -h $PG_HOST -p $PG_PORT -U $PG_USER -d $PG_DB_NAME > $PG_BACKUP_PATH

# Authenticate to GCP
gcloud auth activate-service-account --key-file $GCP_KEY_PATH

# Push the backup to Cloud Storage
gsutil cp $PG_BACKUP_PATH gs://podkrepibg-backups
