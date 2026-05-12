resource "yandex_vpc_security_group" "bastion" {
  name       = "bastion-sg"
  network_id = var.network_id

  ingress {
    protocol       = "TCP"
    description    = var.ssh_access.rule_name
    v4_cidr_blocks = [var.ssh_access.ip]
    port           = 22
  }

  egress {
    protocol       = "ANY"
    description    = "allow-all-egress"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "private" {
  name       = "private-sg"
  network_id = var.network_id

  ingress {
    protocol          = "TCP"
    description       = "ssh-from-bastion"
    security_group_id = yandex_vpc_security_group.bastion.id
    port              = 22
  }

  egress {
    protocol       = "ANY"
    description    = "allow-all-egress"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}