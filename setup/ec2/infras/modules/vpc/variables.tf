variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC"
  default     = "jenkins-vpc"
}

variable "vpc_subnet" {
  type = object({
    name = string
    cidr_block = string
  })
  description = "Subnet to create in the VPC"
  default = {
    name       = "jenkins-subnet"
    cidr_block = "10.0.1.0/24"
  }
}