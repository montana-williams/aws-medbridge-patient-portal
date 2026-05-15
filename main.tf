module "vpc" {
    source = "./modules/vpc"

    vpc_cidr              = var.vpc_cidr
    public_subnet_1_cidr  = var.public_subnet_1_cidr
    public_subnet_2_cidr  = var.public_subnet_2_cidr
    private_subnet_1_cidr = var.private_subnet_1_cidr
    private_subnet_2_cidr = var.private_subnet_2_cidr
}

module "security" {
    source = "./modules/security"

    vpc_id = module.vpc.vpc_id
}