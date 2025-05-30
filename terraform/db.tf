resource "digitalocean_database_cluster" "db" {
  name       = "db"
  engine     = "pg"
  version    = "17"
  size       = "db-s-1vcpu-1gb"
  region     = var.region
  node_count = 1
}

resource "digitalocean_database_connection_pool" "dev" {
  cluster_id = digitalocean_database_cluster.db.id
  name       = "dev"
  mode       = "transaction"
  size       = 3
  db_name    = "dev"
}

resource "digitalocean_database_connection_pool" "prod" {
  cluster_id = digitalocean_database_cluster.db.id
  name       = "prod"
  mode       = "transaction"
  size       = 10
  db_name    = "prod"
}

resource "digitalocean_database_firewall" "db-cluster-access" {
  cluster_id = digitalocean_database_cluster.db.id

  rule {
    type  = "k8s"
    value = digitalocean_kubernetes_cluster.cluster.id
  }

  rule {
    type  = "ip_addr"
    value = "78.130.215.13"
  }

  depends_on = [ digitalocean_kubernetes_cluster.cluster ]
}

resource "digitalocean_database_db" "keycloak" {
  cluster_id = digitalocean_database_cluster.db.id
  name       = "keycloak"
}

resource "digitalocean_database_user" "keycloak" {
  cluster_id = digitalocean_database_cluster.db.id
  name       = "keycloak"
}

resource "digitalocean_database_db" "dev" {
  cluster_id = digitalocean_database_cluster.db.id
  name       = "dev"
}

resource "digitalocean_database_user" "dev" {
  cluster_id = digitalocean_database_cluster.db.id
  name       = "dev"
}

resource "digitalocean_database_db" "prod" {
  cluster_id = digitalocean_database_cluster.db.id
  name       = "prod"
}

resource "digitalocean_database_user" "prod" {
  cluster_id = digitalocean_database_cluster.db.id
  name       = "prod"
}

# Ghost db
resource "digitalocean_database_cluster" "ghost-db" {
  name       = "ghost-db"
  engine     = "mysql"
  version    = "8"
  size       = "db-s-1vcpu-1gb"
  region     = var.region
  node_count = 1
}

resource "digitalocean_database_firewall" "ghost-db-cluster-access" {
  cluster_id = digitalocean_database_cluster.ghost-db.id

  rule {
    type  = "k8s"
    value = digitalocean_kubernetes_cluster.cluster.id
  }

  rule {
    type  = "ip_addr"
    value = "78.130.215.13"
  }

  depends_on = [ digitalocean_kubernetes_cluster.cluster ]
}

resource "digitalocean_database_db" "ghost" {
  cluster_id = digitalocean_database_cluster.ghost-db.id
  name       = "ghost"
}

resource "digitalocean_database_user" "ghost" {
  cluster_id = digitalocean_database_cluster.ghost-db.id
  name       = "ghost"
}