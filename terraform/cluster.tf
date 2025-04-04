resource "digitalocean_kubernetes_cluster" "cluster" {
  name   = "cluster"
  region = var.region
  # Grab the latest version slug from `doctl kubernetes options versions`
  version = "1.32.2-do.0"

  node_pool {
    name       = "worker-pool"
    size       = "s-2vcpu-4gb"
    node_count = 2
  }
}