terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }

  cloud { 
    organization = "Podkrepibg" 

    workspaces { 
      name = "digitalocean" 
    } 
  } 
}

variable "do_token" {}

variable "region" {
  default = "fra1"
}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_project" "pokrepibg" {
  name        = "podkrepibg"
  description = "A project to represent podkrepi.bg resources."
  purpose     = "Web Application"
  environment = "production"
  is_default  = true
  resources   = [
    digitalocean_kubernetes_cluster.cluster.urn,
    digitalocean_database_cluster.db.urn,
  ]
}