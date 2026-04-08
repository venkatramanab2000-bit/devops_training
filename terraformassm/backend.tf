terraform {
  backend "s3" {
    bucket         = "venkatramana-s3-bucket"
    key            = "eks/terraform.tfstate"
    region         = "ap-south-1"
  }
}