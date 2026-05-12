variable "network_id" {
  type = string
}

variable "ssh_access" {
  type = object({
    rule_name = string
    ip        = string

  })
}