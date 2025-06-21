resource "digitalocean_kubernetes_cluster" "cluster" {
  name   = "cluster"
  region = var.region
  # Grab the latest version slug from `doctl kubernetes options versions`
  version = "1.32.2-do.0"

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
  leaf_certificate = file("./cert.pem")
  certificate_chain = file("./chain.pem")
}