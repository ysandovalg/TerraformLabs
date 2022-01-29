terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
    local = {
      source = "hashicorp/local"
    }
    tls = {
      source = "hashicorp/tls"
    }
    # acme = {
    #   source  = "vancluever/acme"
    #   version = "~> 2.5.3"
    # }
  }
  required_version = ">= 1.1"
}
