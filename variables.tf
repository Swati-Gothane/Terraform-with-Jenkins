variable "vpc_cidr_block" {
  type = string
}

variable "vpc_subnet_1_cidr_block" {
    type = string
    description = "(optional) describe your variable"
}

variable "vpc_subnet_2_cidr_block" {
    type = string
    description = "(optional) describe your variable"
}

variable "vpc_availability_1_zone" {
    type = string
  
}

variable "vpc_availability_2_zone" {
    type = string
  
}

# Variables
variable "cluster_name" {
    type = string
  default = "my-eks-cluster"
}