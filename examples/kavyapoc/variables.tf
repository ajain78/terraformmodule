variable "region" {
  type        = string
  description = "AWS region"
}

variable "alb_listener_port" {
  type        = number
  description = "The port on which the ALB will be listening."
}

/*variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones"
} */

variable "vpc_cidr_block" {
  type        = string
  description = "VPC CIDR block"
}
