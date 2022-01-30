
output "lab-ssh" {
  value = {
    for k, t in google_compute_instance.terra : k => "ssh ${var.username}@${t.network_interface.0.access_config.0.nat_ip} -i ~/Documents/code/dockerlabs/labs/keys/prod/dockerlabkey"
  }
}

output "lab-code" {
  value = {
    for k, t in google_dns_record_set.code_terralabs_tk : k => "${t.name}"
  }
}

output "local-ip" {
  value = {
    for k, t in google_compute_instance.terra : k => t.network_interface.0.network_ip
  }
}

output "IP-list" {
  value = {
    for k, t in google_compute_instance.terra : k => t.network_interface.0.access_config.0.nat_ip
  }
}

output "names" {
  value = {
    for k, t in google_compute_instance.terra : k => t.name
  }
}
