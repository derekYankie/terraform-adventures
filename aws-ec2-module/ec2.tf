locals {
  create = var.create

  find_instance_type = replace(var.instance_type, "/^t(2|3|3a){1}\\..*$/", "1") == "1" ? true : false
}
# AWS EC2 Instance
resource "aws_instance" "ami_server" {
  count = local.create ? 1 : 0

  ami           = "${var.instance_ami}"
  instance_type = "${var.instance_type}"
  subnet_id = "${var.subnet_public_id}"
  vpc_security_group_ids = ["${var.security_group_ids}"]
  key_name = "${var.key_pair_name}"

  tags = {
    Name = "${var.prefix}-${var.aws-profile}-instance"
  }
}
