resource "aws_security_group" "aws-vpc-sg" {
  name   = "us-east-vpc-security-group"
  vpc_id = aws_vpc.staging-vpc.id
  dynamic "ingress" {
    for_each = var.rules
    content {
      from_port    = ingress.value["port"]
      to_port      = ingress.value["port"]
      protocol     = ingress.value["proto"]
      cidr_blocks  = ingress.value["cidr_blocks"]
    }
  }
}
