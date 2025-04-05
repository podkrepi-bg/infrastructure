output "dev_db_pass" {
    value = digitalocean_database_user.dev.password
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