provider "aws" {
  region  = var.aws-region
  profile = var.aws-profile
}

data "aws_caller_identity" "current" {}

locals {
  cluster_name = "eks-cluster-poc"

  tags = {
    DeploymentType      = "Terraform"
    Environment         = "Staging"
    Owner               = "derekYankie"
    Infrastructure      = "AWS-Cloud"
  }

  k8s_labels = {
        Environment     = "Staging"
        Infrastructure  = "AWS-Cloud"
        Owner           = "derekYankie"
    }
}

##### VPC Module #####

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.3"

  name = var.eks_vpc_name
  cidr = "10.0.0.0/16"

  azs             = ["${var.aws-region}a", "${var.aws-region}b"]
  private_subnets = ["10.0.4.0/22", "10.0.12.0/22"]
  public_subnets  = ["10.0.100.0/22", "10.0.104.0/22"]

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = local.tags
}

##### EKS Module #####

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.29.0"

  cluster_name    = local.cluster_name
  cluster_version = "1.24"

  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets
  cluster_endpoint_public_access = true

  eks_managed_node_group_defaults = {
    # Node Group compute configuration
    ami_type = "AL2_x86_64"
    capacity_type  = "ON_DEMAND"
  }

  eks_managed_node_groups = {
    mg_one = {
      name = "mg-node-group-1"

      instance_types = ["t3.small"]

      # Scaling configuration
      min_size        = 1
      max_size        = 3
      desired_size    = 2
      max_unavailable = 1

      # Node selector
      k8s_labels = local.k8s_labels
    }

    mg_two = {
      name = "mg-node-group-2"

      instance_types = ["t3.small"]

      # Scaling configuration
      min_size        = 1
      max_size        = 3
      desired_size    = 2
      max_unavailable = 1

      # Node selector
      k8s_labels = local.k8s_labels
    }
  }


  tags = local.tags
}

##### IAM Policy #####

module "allow_eks_access_iam_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "5.3.1"

  name          = "allow-eks-access-2"
  create_policy = true

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "eks:DescribeCluster",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

##### IAM Role #####

module "eks_admins_iam_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "5.3.1"

  role_name         = "eks-cluster-admin-1"
  create_role       = true
  role_requires_mfa = false

  custom_role_policy_arns = [module.allow_eks_access_iam_policy.arn]

  trusted_role_arns = [
    "arn:aws:iam::${module.vpc.vpc_owner_id}:root"
  ]
}

##### IAM User #####

module "eks_iam_user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "5.3.1"

  name                          = "iam-eks-user1"
  create_iam_access_key         = false
  create_iam_user_login_profile = false

  force_destroy = true
}

module "allow_assume_eks_admins_iam_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "5.3.1"

  name          = "allow-assume-eks-admin2-iam-role"
  create_policy = true

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
        ]
        Effect   = "Allow"
        Resource = module.eks_admins_iam_role.iam_role_arn
      },
    ]
  })
}

module "eks_admins_iam_group" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"
  version = "5.3.1"

  name                              = "eks-admin-group"
  attach_iam_self_management_policy = false
  create_group                      = true
  group_users                       = [module.iam-eks-user1_iam_user.iam_user_name]
  custom_group_policy_arns          = [module.allow_assume_eks_admins_iam_policy.arn]
}
