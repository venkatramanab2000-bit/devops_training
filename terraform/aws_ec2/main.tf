resource "aws_instance" "venkat-example" {
  for_each      = var.instance_type
  ami           = var.ami_id
  instance_type = each.value

  tags = {
    Name = each.key
  }
}