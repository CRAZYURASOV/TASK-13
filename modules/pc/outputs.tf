output "bastion_public_ip" {
  value = yandex_compute_instance.bastion.network_interface[0].nat_ip_address
}

output "bastion_internal_ip" {
  value = yandex_compute_instance.bastion.network_interface[0].ip_address
}

output "private_server_internal_ip" {
  value = yandex_compute_instance.private_server.network_interface[0].ip_address
}