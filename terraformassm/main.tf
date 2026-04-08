# -------------------------
# ECR Repository
# -------------------------
resource "aws_ecr_repository" "venkat_ecr" {
  name = "venkat-ecr-repo"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "venkat-ecr"
  }
}

# -------------------------
# IAM Role for EKS
# -------------------------
resource "aws_iam_role" "eks_role" {
  name = "venkat-eks-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_policy" {
  role       = aws_iam_role.eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# -------------------------
# VPC (Minimal for EKS)
# -------------------------
resource "aws_vpc" "eks_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "eks_subnet" {
  count = 2

  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = cidrsubnet(aws_vpc.eks_vpc.cidr_block, 8, count.index)
  availability_zone = element(["ap-south-1a", "ap-south-1b"], count.index)
}

# -------------------------
# EKS Cluster
# -------------------------
resource "aws_eks_cluster" "venkat_eks" {
  name     = "venkat-eks-cluster"
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = aws_subnet.eks_subnet[*].id
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_policy
  ]
}