provider "google" {
  credentials = file(var.gcp_account_json)
  project     = var.gcp_project
  region      = var.gcp_region
}

provider "tls" {
}

