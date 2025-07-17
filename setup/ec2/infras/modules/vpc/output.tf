output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.jenkins-vpc.id
}

output "public_sg_id" {
  description = "The ID of the public security group"
  value       = aws_security_group.jenkins-public-sg.id
}

output "subnet_id" {
  description = "List of public subnet ID"
  value       = aws_subnet.jenkins.id
}