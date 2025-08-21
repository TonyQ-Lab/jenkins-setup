variable "subnet_id" {
  description = "The ID of the subnet where the EC2 instances will be launched"
  type        = string
  default     = ""
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with the EC2 instances"
  type        = list(string)
  default     = []
}

variable "instance_name" {
  description = "The name tag for the EC2 instance"
  type        = string
  default     = "my-server"
}