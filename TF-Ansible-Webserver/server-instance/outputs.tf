output "server_instance_eip_id" {
  description = "Instance EIP address assigned to the instance."
  value = try(aws_eip.ami_instance_EIP[0].association_id)
}

#  Server Instance Addresses 
output "server_private_ip" {
value = module.ec2-instance.private_ip
}

output "server_public_ipv4" {
value = module.ec2-instance.public_ip
}

output "server_id" {
value = module.ec2-instance.id
}

output "server_eip_public_ip" {
  description = "Instance EIP address assigned to the instance."
  value = try(aws_eip.ami_instance_EIP[0].public_ip)
}
