
output "lab-ssh" {
  value = {
    for k, t in google_compute_instance.terra : k => "ssh ${var.username}@${t.network_interface.0.access_config.0.nat_ip} -i ~/Documents/code/dockerlabs/labs/keys/prod/dockerlabkey"
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
