resource "aws_s3_bucket" "venkat_example" {
  bucket = var.s3_bucket_name

  tags = {
    Name = "venkat-example"
  }
}