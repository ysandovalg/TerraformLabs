# resource "tls_private_key" "private_key" {
#   algorithm = "RSA"
# }

# resource "acme_registration" "registration" {
#   account_key_pem = tls_private_key.private_key.private_key_pem
#   email_address   = "info@storylabs.tk"
# }

# resource "acme_certificate" "certificate" {
#   for_each = toset(var.users)

#   account_key_pem           = acme_registration.registration.account_key_pem
#   common_name               = google_dns_managed_zone.terralabs_tk.name
#   subject_alternative_names = ["${each.value}.${google_dns_managed_zone.terralabs_tk.name}"]

#   dns_challenge {
#     provider = "gcloud"

#     # config = {
#     #   AWS_HOSTED_ZONE_ID = google_dns_managed_zone.terralabs_tk.id
#     # }
#   }

#   depends_on = [acme_registration.registration]
# }
