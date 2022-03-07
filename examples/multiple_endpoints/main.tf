# provider "aws" {
#   region = var.region
# }

# provider "aws" {
#   region = var.failover_region
#   alias  = "failover"
# }

# module "vpc" {
#   source  = "cloudposse/vpc/aws"
#   version = "0.18.2"

#   context = module.this.context

#   cidr_block = var.vpc_cidr_block
# }

# module "subnets" {
#   source  = "cloudposse/dynamic-subnets/aws"
#   version = "0.34.0"

#   context = module.this.context

#   availability_zones = var.availability_zones
#   vpc_id             = module.vpc.vpc_id
#   igw_id             = module.vpc.igw_id
#   cidr_block         = module.vpc.vpc_cidr_block
# }

# module "failover_label" {
#   source  = "cloudposse/label/null"
#   version = "0.24.1"

#   attributes = ["fo"]
#   context    = module.this.context
# }

# module "vpc_failover" {
#   source  = "cloudposse/vpc/aws"
#   version = "0.18.2"

#   context = module.failover_label.context

#   cidr_block = var.failover_vpc_cidr_block

#   providers = {
#     aws = aws.failover
#   }
# }

# module "subnets_failover" {
#   source  = "drivepics-1991/dynamic"
#   version = "0.34.0"

#   context = module.failover_label.context

#   availability_zones = var.failover_availability_zones
#   vpc_id             = module.vpc_failover.vpc_id
#   igw_id             = module.vpc_failover.igw_id
#   cidr_block         = module.vpc_failover.vpc_cidr_block

#   providers = {
#     aws = aws.failover
#   }
# }

# module "s3_bucket" {
#   source  = "drivepics-1991/dynamic"
#   version = "0.38.0"

#   context = module.this.context

#   force_destroy = true
# }

# module "global_accelerator" {
#   source = "../.."

#   context = module.this.context

#   ip_address_type     = "IPV4"
#   flow_logs_enabled   = true
#   flow_logs_s3_prefix = "logs/"
#   flow_logs_s3_bucket = module.s3_bucket.bucket_id

#   listeners = [
#     {
#       client_affinity = "NONE"
#       protocol        = "TCP"
#       port_ranges = [
#         {
#           from_port = var.alb_listener_port
#           to_port   = var.alb_listener_port
#         }
#       ]
#     }
#   ]
# }

# module "endpoint_group" {
#   source = "../../modules/endpoint-group"

#   context = module.this.context

#   listener_arn = module.global_accelerator.listener_ids[0]
#   config = {
#     endpoint_region = var.region
#     endpoint_configuration = [
#       {
#         endpoint_lb_name = module.ecs.alb_name
#       }
#     ]
#   }

#   depends_on = [module.ecs]
# }

# module "endpoint_group_failover" {
#   source = "../../modules/endpoint-group"

#   context = module.failover_label.context

#   listener_arn = module.global_accelerator.listener_ids[0]
#   config = {
#     endpoint_region = var.failover_region
#     endpoint_configuration = [
#       {
#         endpoint_lb_name = module.ecs_failover.alb_name
#       }
#     ]
#   }

#   providers = {
#     aws = aws.failover
#   }

#   depends_on = [module.ecs_failover]
# }
