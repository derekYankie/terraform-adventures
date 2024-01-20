resource "aws_security_group" "aws-vpc-sg" {
  name   = "us-east-vpc-security-group"
  vpc_id = aws_vpc.staging-vpc.id
}
