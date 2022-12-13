# EC2 Instance Resources
module "ec2-instance" {
  source = "../aws-ec2-module"

  name = "${var.aws-profile}-Nginx-Server"

  ami           = "${var.instance_ami}"
  instance_type = "${var.instance_type}"
  subnet_id = "${var.subnet_public_id}"
  vpc_security_group_ids = ["${var.security_group_ids}"]
  key_name = aws_key_pair.nginx-server-demo

  tags = {
    Name = "${var.prefix}-${var.aws-profile}-instance"
  }
}
# Create Key Pair for Server
resource "aws_key_pair" "nginx-server-demo" {
key_name = "nginx-server"
public_key = tls_private_key.rsa.public_key_openssh
}
resource "tls_private_key" "rsa" {
algorithm = "RSA"
rsa_bits  = 4096
}
resource "local_file" "tf-key" {
content  = tls_private_key.rsa.private_key_pem
filename = "nginx-server"
}

resource "aws_eip" "server_addr" {
  count = (var.create_eip) ? 1 : 0
  vpc      = true
 
  lifecycle {
    # Enable Deletion After Sucessful Demo 
    prevent_destroy = false
  }
  tags = {
    Name = "${var.prefix}-${var.aws-profile}-instance"
  }
}

resource "aws_eip_association" "server_eip_assoc" {
  count = (var.create_eip) ? 1 : 0
 
  instance_id   = module.ec2-instance.id[0]
  allocation_id = aws_eip.server_addr[0].id
}
