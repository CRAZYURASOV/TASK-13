data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2204-lts"
}

resource "yandex_compute_instance" "bastion" {
  name        = "tf-bastion"
  hostname    = "tf-bastion"
  zone        = var.zone
  platform_id = "standard-v3"

  description = "Bastion host with public IP"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = 15
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id          = var.public_subnet_id
    nat                = true
    security_group_ids = [var.bastion_sg_id]
  }

  metadata = {
    ssh-keys = "${var.vm_user}:${file(var.ssh_public_key_path)}"
  }
}

resource "yandex_compute_instance" "private_server" {
  name        = "tf-lab-private-server"
  hostname    = "tf-lab-private-server"
  zone        = var.zone
  platform_id = "standard-v3"

  description = "Private server without public IP"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = 15
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id          = var.private_subnet_id
    nat                = false
    security_group_ids = [var.private_sg_id]
  }

  metadata = {
    ssh-keys = "${var.vm_user}:${file(var.ssh_public_key_path)}"
  }
}