terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = [var.credential_file]
}

# VPC
module "vpc" {
  source   = "./modules/vpc"
  vpc_name = "jenkins-vpc"
}

module "ec2" {
  depends_on         = [module.vpc]
  source             = "./modules/ec2"
  subnet_id          = module.vpc.subnet_id
  security_group_ids = [module.vpc.public_sg_id]
}

output "server_ip" {
  description = "The public IP of the Jenkins server"
  value       = module.ec2.instance_public_ips
}