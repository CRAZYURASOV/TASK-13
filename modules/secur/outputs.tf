output "bastion_sg_id" {
  value = yandex_vpc_security_group.bastion.id
}

output "private_sg_id" {
  value = yandex_vpc_security_group.private.id
}