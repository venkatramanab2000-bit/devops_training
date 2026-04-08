module "aws_ec2" {
  source = "./aws_ec2"
  ami_id = var.ami_id
  instance_type = var.instance_type
}

module "aws_s3" {
  source = "./aws_s3"
  s3_bucket_name=var.bucketname
}