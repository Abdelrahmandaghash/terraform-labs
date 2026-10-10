



module "network" {
  source               = "./modules/network"
  name                 = terraform.workspace
  vpc_cidr             = var.vpc_cidr
  azs                  = var.azs
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "ec2" {
  source             = "./modules/ec2"
  name               = terraform.workspace
  vpc_id             = module.network.vpc_id
  vpc_cidr           = var.vpc_cidr
  public_subnet_ids  = module.network.public_subnet_ids
  private_subnet_ids = module.network.private_subnet_ids
  instance_type      = var.instance_type
  ami_id             = var.ami_id

  depends_on = [module.network]
}

module "lb" {
  source               = "./modules/lb"
  name                 = terraform.workspace
  vpc_id               = module.network.vpc_id
  vpc_cidr             = var.vpc_cidr
  public_subnet_ids    = module.network.public_subnet_ids
  private_subnet_ids   = module.network.private_subnet_ids
  public_instance_ids  = module.ec2.public_instance_ids
  private_instance_ids = module.ec2.private_instance_ids

  depends_on = [module.ec2]
}