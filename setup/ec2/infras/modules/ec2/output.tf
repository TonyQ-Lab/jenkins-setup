# List of all instance IDs created by this module
output "instance_ids" {
  description = "List of all instance IDs created by this module"
  value       = aws_instance.server.id
}

output "instance_public_ips" {
  description = "Public IP addresses of the Jenkins server"
  value       = aws_instance.server.public_ip
}