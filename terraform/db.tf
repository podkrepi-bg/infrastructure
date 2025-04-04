resource "digitalocean_database_cluster" "db" {
  name       = "db"
  engine     = "pg"
  version    = "17"
  size       = "db-s-1vcpu-1gb"
  region     = var.region
  node_count = 1
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