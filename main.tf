module "vpc" {
  source = "./modules/vpc"

  network_name        = "tf-network"
  public_subnet_name  = "public_subnet"
  private_subnet_name = "private_subnet"

  zone = var.zone

  public_cidr  = "10.10.1.0/24"
  private_cidr = "10.10.2.0/24"

}


module "secur" {
  source = "./modules/secur"

  network_id = module.vpc.network_id
  ssh_access = var.ssh_access
}


module "pc" {
  source = "./modules/pc"

  zone                = var.zone
  vm_user             = var.vm_user
  ssh_public_key_path = var.ssh_public_key_path

  public_subnet_id  = module.vpc.public_subnet_id
  private_subnet_id = module.vpc.private_subnet_id

  bastion_sg_id = module.secur.bastion_sg_id
  private_sg_id = module.secur.private_sg_id


}