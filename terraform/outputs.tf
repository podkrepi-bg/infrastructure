output "dev_db_pass" {
    value = digitalocean_database_user.dev.password
    sensitive = true
}

output "prod_db_pass" {
    value = digitalocean_database_user.prod.password
    sensitive = true
}

output "prod_backup_job_db_pass" {
    value = digitalocean_database_user.prod-backup-job.password
    sensitive = true
}

output "keycloak_db_pass" {
    value = digitalocean_database_user.keycloak.password
    sensitive = true
}

output "dev_bucket_access_key" {
    value = digitalocean_spaces_key.dev.access_key
}

output "dev_bucket_secret_key" {
    value = digitalocean_spaces_key.dev.secret_key
    sensitive = true
}

output "prod_bucket_access_key" {
    value = digitalocean_spaces_key.prod.access_key
}

output "prod_bucket_secret_key" {
    value = digitalocean_spaces_key.prod.secret_key
    sensitive = true
}

output "ghost_cert_name" {
    value = digitalocean_certificate.ghost-cert.name
}