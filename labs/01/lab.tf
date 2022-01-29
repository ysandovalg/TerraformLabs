resource "google_compute_address" "external_address" {
  for_each = toset(var.users)

  name   = "${var.subdomain}-${each.value}"
  region = var.gcp_region
}
resource "google_compute_instance" "terra" {
  for_each = toset(var.users)

  name         = "${var.subdomain}-${each.value}"
  machine_type = var.machine_type
  zone         = var.gcp_zone_a
  tags         = ["terralabs"]
  labels = merge({
    name = var.subdomain
    },
    var.default_tags
  )

  boot_disk {
    initialize_params {
      image = data.google_compute_image.master_image.self_link
      size  = var.disk_size
      type  = var.disk_type

      labels = merge({
        name = var.subdomain
        },
        var.default_tags
      )
    }
  }

  network_interface {
    network = "default"

    access_config {
      nat_ip = google_compute_address.external_address[each.value].address
    }
  }

  metadata = {
    ssh-keys = "${var.username}:${file(var.ssh_pub_key)}"
    user-data = templatefile("../conf/template.sh",
      {
        username = var.username
        codepass = var.codepass
    })
  }

  provisioner "file" {
    source      = "../conf/config.yaml"
    destination = "/home/${var.username}/config.yaml"

    connection {
      type        = "ssh"
      host        = self.network_interface.0.access_config.0.nat_ip
      user        = var.username
      private_key = file(var.ssh_key)
    }
  }

  provisioner "file" {
    source      = "../conf/code-server.conf"
    destination = "/home/${var.username}/code-server.conf"

    connection {
      type        = "ssh"
      host        = self.network_interface.0.access_config.0.nat_ip
      user        = var.username
      private_key = file(var.ssh_key)
    }
  }

  provisioner "file" {
    source      = "../conf/webserver.conf"
    destination = "/home/${var.username}/webserver.conf"

    connection {
      type        = "ssh"
      host        = self.network_interface.0.access_config.0.nat_ip
      user        = var.username
      private_key = file(var.ssh_key)
    }
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Waiting for cloud-init to complete...'",
      "cloud-init status --wait > /dev/null",
      "echo 'Completed cloud-init!!'"
    ]

    connection {
      type        = "ssh"
      host        = self.network_interface.0.access_config.0.nat_ip
      user        = var.username
      private_key = file(var.ssh_key)
    }
  }

  provisioner "local-exec" {
    command = <<EOT
  		ssh-keygen -f ~/.ssh/known_hosts -R "${self.network_interface.0.access_config.0.nat_ip}"
  	EOT
  }
}


