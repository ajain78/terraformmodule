variable "region" {
  type        = string
  description = "AWS region"
}

variable "ganame" {
  description = "global name"
  type        = string
  default = "multi-global-accelerator"
}

variable "alb_listener_port" {
  type        = number
  description = "The port on which the ALB will be listening."
}

variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones"
}

variable "vpc_cidr_block" {
  type        = string
  description = "VPC CIDR block"
}

variable "failover_region" {
  type        = string
  description = "AWS region to deploy the failover endpoint"
}

variable "failover_availability_zones" {
  type        = list(string)
  description = "List of availability zones for the failover region"
}

variable "failover_vpc_cidr_block" {
  type        = string
  description = "VPC CIDR block for the failover region"
}
