// terralabs.tk
resource "google_dns_managed_zone" "terralabs_tk" {
  name        = "terralabs-tk"
  dns_name    = "terralabs.tk."
  description = "Terraform tk zone"
  labels = {
    env = "dev"
  }

  lifecycle {
    prevent_destroy = true
  }

}
resource "google_dns_record_set" "user_terralabs_tk" {
  depends_on = [google_dns_managed_zone.terralabs_tk]

  for_each = toset(var.users)
  name     = format("%s.%s.%s.", "${each.value}", var.domain, "tk")

  type         = "A"
  ttl          = 300
  managed_zone = google_dns_managed_zone.terralabs_tk.name
  rrdatas      = [google_compute_instance.terra[each.key].network_interface.0.access_config.0.nat_ip]
}

resource "google_dns_record_set" "www_user_terralabs_tk" {
  depends_on = [google_dns_managed_zone.terralabs_tk]

  for_each = toset(var.users)
  name     = format("www.%s.%s.%s.", "${each.value}", var.domain, "tk")

  type         = "A"
  ttl          = 300
  managed_zone = google_dns_managed_zone.terralabs_tk.name
  rrdatas      = [google_compute_instance.terra[each.key].network_interface.0.access_config.0.nat_ip]
}


resource "google_dns_record_set" "code_terralabs_tk" {
  depends_on = [google_dns_managed_zone.terralabs_tk]

  for_each = toset(var.users)
  name     = format("code.%s.%s.%s.", "${each.value}", var.domain, "tk")

  type         = "A"
  ttl          = 300
  managed_zone = google_dns_managed_zone.terralabs_tk.name
  rrdatas      = [google_compute_instance.terra[each.key].network_interface.0.access_config.0.nat_ip]
}
