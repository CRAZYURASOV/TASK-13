variable "cloud_id" {
  type = string
}

variable "folder_id" {
  type = string
}


variable "service_account_key_file" {
  type    = string
  default = "./key.json"
}

variable "zone" {
  type    = string
  default = "ru-central1-b"
}

variable "ssh_public_key_path" {
  description = "Path to public SSH key"
  type        = string
}

variable "vm_user" {
  description = "Linux user for SSH"
  type        = string
  default     = "ubuntu"
}

variable "ssh_access" {
  description = "Object with SSH rule name and allowed IP in CIDR format"
  type = object({
    rule_name = string
    ip        = string
  })
}