provider "aws" {
	region = var.region
	default_tags  {
		  tags = {
			Terraform = "true"
			Environment = "dev"
			Usage = "Kubernetes"
			Version = "1.0"
			Project = "vpc-good-pratices"
			CreatedAt = formatdate("YYYY-MM-DD", timestamp())
		}
	}
}

