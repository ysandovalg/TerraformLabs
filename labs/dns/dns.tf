resource "google_dns_managed_zone" "terralabs_tk" {
  name        = "terralabs-tk"
  dns_name    = "terralabs.tk."
  description = "terralabs demos"
  labels = {
    env  = "dev"
    type = "labs"
  }
}
