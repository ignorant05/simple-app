
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

provider "aws" {
  region = var.region
}


# VPC 
module "vpc" {
  source     = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
  region     = var.region
  vpc_name   = var.cluster_name
}


# IGW
module "igw" {
  source             = "./modules/igw"
  cluster_name       = var.cluster_name
  vpc_id             = module.vpc.vpc_id
  public_subnet_a_id = module.vpc.public_subnet_a_id
  public_subnet_b_id = module.vpc.public_subnet_b_id
}

# IAM
module "iam" {
  source       = "./modules/iam"
  cluster_name = var.cluster_name
}

# EKS Cluster
module "eks" {
  source             = "./modules/eks"
  cluster_name       = var.cluster_name
  role_arn           = module.iam.node_role_arn
  public_subnet_a_id = module.vpc.public_subnet_a_id
  public_subnet_b_id = module.vpc.public_subnet_b_id
  eks_policy         = module.iam.eks_policy
}

# EC2 Worker Nodes (Node Group)
module "ec2" {
  source             = "./modules/ec2"
  instance_type      = var.instance_type
  cluster_name       = var.cluster_name
  node_role_arn      = module.iam.node_role_arn
  public_subnet_a_id = module.vpc.public_subnet_a_id
  public_subnet_b_id = module.vpc.public_subnet_b_id
  policies           = module.iam.policies
}




