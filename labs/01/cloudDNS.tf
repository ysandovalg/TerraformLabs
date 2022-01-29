// terralabs.tk
resource "google_dns_managed_zone" "terralabs_tk" {
  name        = "terralabs-tk"
  dns_name    = "terralabs.tk."
  description = "Terraform tk zone"
  labels = {
    env = "dev"
  }
}
resource "google_dns_record_set" "terra_terralabs_tk" {
  count      = var.instance_count
  name       = format("%s%s.%s.%s.", var.subdomain, count.index + 1, var.domain, "tk")

  type         = "A"
  ttl          = 300
  managed_zone = var.domain
  rrdatas      = [google_compute_instance.terra[count.index].network_interface.0.access_config.0.nat_ip]
}

resource "google_dns_record_set" "www_terra_terralabs_tk" {
  count      = var.instance_count
  name       = format("www.%s%s.%s.%s.", var.subdomain, count.index + 1, var.domain, "tk")

  type         = "A"
  ttl          = 300
  managed_zone = var.domain
  rrdatas      = [google_compute_instance.terra[count.index].network_interface.0.access_config.0.nat_ip]
}


resource "google_dns_record_set" "code_terralabs_tk" {
  count      = var.instance_count
  name       = format("code.%s%s.%s.%s.", var.subdomain, count.index + 1, var.domain, "tk")

  type         = "A"
  ttl          = 300
  managed_zone = var.domain
  rrdatas      = [google_compute_instance.terra[count.index].network_interface.0.access_config.0.nat_ip]
}
