provider "google" {
  credentials = file(var.gcp_account_json)
  project     = var.gcp_project
  region      = var.gcp_region
  zone        = var.gcp_zone_a
}

provider "tls" {
}


# provider "acme" {
#   server_url = "https://acme-staging-v02.api.letsencrypt.org/directory"
#   #server_url = "https://acme-v02.api.letsencrypt.org/directory"
# }


