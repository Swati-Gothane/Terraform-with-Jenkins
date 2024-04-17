# Provider configuration for AWS
provider "aws" {
  region = "eu-west-1"  # Update with your desired AWS region
}

# VPC
resource "aws_vpc" "eks_vpc" {
  cidr_block = var.vpc_cidr_block
}

# Subnet for EKS
resource "aws_subnet" "eks_subnet_1" {
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = var.vpc_subnet_1_cidr_block
  availability_zone = var.vpc_availability_1_zone # Update with desired AZ
}
resource "aws_subnet" "eks_subnet_2" {
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = var.vpc_subnet_2_cidr_block
  availability_zone = var.vpc_availability_2_zone  # AZ B
}

# IAM Role for EKS Cluster
resource "aws_iam_role" "eks_cluster_role" {
  name               = "${var.cluster_name}-role"
  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = {
        Service = "eks.amazonaws.com"
      },
      Action    = "sts:AssumeRole"
    }]
  })
}

# EKS Cluster
resource "aws_eks_cluster" "my_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.eks_subnet_1.id,
      aws_subnet.eks_subnet_2.id
    ]
  }
}




output "endpoint" {
  value = aws_eks_cluster.my_cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.my_cluster.certificate_authority[0].data
}