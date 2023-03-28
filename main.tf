module "vpc" {
  source = "./modules/create_vpc"
}

module "subnet" {
  source = "./modules/create_subnet"
}