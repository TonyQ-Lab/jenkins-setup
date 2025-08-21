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

variable "instance_type" {
  description = "EC2 instance type"
  type = string
  default = "t3.small"
}

variable "instance_size" {
  description = "Root volume size of the EC2 instance"
  type        = number
  default     = 12
}