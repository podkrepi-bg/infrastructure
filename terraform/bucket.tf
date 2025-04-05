resource "digitalocean_spaces_bucket" "banktransaction-files-dev" {
  name   = "banktransaction-files-dev"
  region = "fra1"
}

resource "digitalocean_spaces_bucket" "campaign-files-dev" {
  name   = "campaign-files-dev"
  region = "fra1"
}

resource "digitalocean_spaces_bucket" "campaign-news-files-dev" {
  name   = "campaign-news-files-dev"
  region = "fra1"
}

resource "digitalocean_spaces_bucket" "campaignapplication-files-dev" {
  name   = "campaignapplication-files-dev"
  region = "fra1"
}

resource "digitalocean_spaces_bucket" "expenses-files-dev" {
  name   = "expenses-files-dev"
  region = "fra1"
}

resource "digitalocean_spaces_bucket" "irregularity-files-dev" {
  name   = "irregularity-files-dev"
  region = "fra1"
}

resource "digitalocean_spaces_key" "dev" {
  name = "dev"
  grant {
    bucket     = "banktransaction-files-dev"
    permission = "readwrite"
  }
  grant {
    bucket     = "campaign-files-dev"
    permission = "readwrite"
  }
  grant {
    bucket     = "campaign-news-files-dev"
    permission = "readwrite"
  }
  grant {
    bucket = "campaignapplication-files-dev"
    permission = "readwrite"
  }
  grant {
    bucket     = "expenses-files-dev"
    permission = "readwrite"
  }
  grant {
    bucket     = "irregularity-files-dev"
    permission = "readwrite"
  }

  depends_on = [ 
    digitalocean_spaces_bucket.banktransaction-files-dev,
    digitalocean_spaces_bucket.campaign-files-dev,
    digitalocean_spaces_bucket.campaign-news-files-dev,
    digitalocean_spaces_bucket.campaignapplication-files-dev,
    digitalocean_spaces_bucket.expenses-files-dev,
    digitalocean_spaces_bucket.irregularity-files-dev,
]
}