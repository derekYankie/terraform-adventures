output "ami_instance_id" {
  description = "The ID of the instance server."
  value       = try(aws_instance.ami_instance[0].id, "")
}

output "ami_instance_arn" {
  description = "The ARN of the instance."
  value       = try(aws_instance.ami_instance[0].arn, "")
}

output "server_instance_outpost_arn" {
  description = "The ARN of the Outpost the instance is assigned to"
  value       = try(aws_instance.ami_instance[0].outpost_arn, "")
}

output "server_instance_eip_id" {
  description = "Instance EIP address assigned to the instance."
  value = try(aws_eip.ami_instance_EIP[0].association_id)
}

output "server_eip_public_ip" {
  description = "Instance EIP address assigned to the instance."
  value = try(aws_eip.ami_instance_EIP[0].public_ip)
}
