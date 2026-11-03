data "digitalocean_kubernetes_versions" "cluster" {
  version_prefix = "1.37."
}

resource "digitalocean_kubernetes_cluster" "cluster" {
  name    = "cluster"
  region  = var.region
  version = data.digitalocean_kubernetes_versions.cluster.latest_version

  # Automatically apply patch releases during the maintenance window.
  auto_upgrade  = true
  surge_upgrade = true

  maintenance_policy {
    day        = "sunday"
    start_time = "03:00"
  }

  node_pool {
    name       = "worker-pool"
    size       = "s-2vcpu-4gb"
    node_count = 3
  }
}

resource "digitalocean_certificate" "ghost-cert" {
  name              = "ghost-cert"
  type              = "custom"
  private_key       = file("./privkey.pem")
  leaf_certificate  = file("./cert.pem")
  certificate_chain = file("./chain.pem")
}
