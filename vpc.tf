module "vpc"  {
  source = "terraform-aws-modules/vpc/aws"

  name = "eks-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a","us-east-1b","us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  
  enable_nat_gateway = true
  enable_vpn_gateway = true
  enable_dns_hostnames = true
  single_nat_gateway = true

  tags = {
			Terraform = "true"
			Environment = "dev"
			Usage = "Kubernetes"
			Version = "1.0"
			Project = "vpc-good-pratices"
			CreatedAt = formatdate("YYYY-MM-DD", timestamp())
	}
}

module "vpc_bkp"  {
  source = "terraform-aws-modules/vpc/aws"

  name = "eks-vpc-bkp"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a","us-east-1b","us-east-1c"]
  private_subnets = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  public_subnets  = ["10.0.104.0/24", "10.0.105.0/24", "10.0.106.0/24"]
  
  enable_nat_gateway = true
  enable_vpn_gateway = true
  enable_dns_hostnames = true
  single_nat_gateway = true

  tags = {
			Terraform = "true"
			Environment = "dev"
			Usage = "Kubernetes"
			Version = "1.0"
			Project = "vpc-good-pratices"
			CreatedAt = formatdate("YYYY-MM-DD", timestamp())
	}
}

resource "aws_vpc_peering_connection" "vpc_peering_connection" {
  vpc_id      = module.vpc.vpc_id
  peer_vpc_id = module.vpc_bkp.vpc_id
  auto_accept = true
}

resource "aws_vpc_peering_connection_options" "vpc_peering_options" {
  vpc_peering_connection_id = module.vpc.vpc_id

  accepter {
    allow_remote_vpc_dns_resolution = true
  }
}

