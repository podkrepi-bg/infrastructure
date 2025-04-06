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

variable "access_id" {}

variable "secret_key" {}

variable "region" {
  default = "fra1"
}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
  spaces_access_id  = var.access_id
  spaces_secret_key = var.secret_key
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
    digitalocean_database_cluster.ghost-db.urn,
  ]
}

resource "digitalocean_project" "pokrepibg-dev" {
  name        = "podkrepibg-dev"
  description = "A project to represent podkrepi.bg dev resources."
  purpose     = "Web Application"
  environment = "development"
  resources   = [
    digitalocean_spaces_bucket.banktransaction-files-dev.urn,
    digitalocean_spaces_bucket.campaign-files-dev.urn,
    digitalocean_spaces_bucket.campaign-news-files-dev.urn,
    digitalocean_spaces_bucket.campaignapplication-files-dev.urn,
    digitalocean_spaces_bucket.expenses-files-dev.urn,
    digitalocean_spaces_bucket.irregularity-files-dev.urn,
  ]
}