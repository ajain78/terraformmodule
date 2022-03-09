provider "aws" {
  region = var.region
}
####
#Pass the bucker module when reuqired.
####
# module "s3_bucket" {
#   source  = "cloudposse/s3-bucket/aws"     
#   version = "0.38.0"
#   force_destroy = true
# }

####
#Pass the load balancer module when reuqired.
####
# module "lb" {
#   source  = "cloudposse/lb/aws"     
#   version = "0.38.0"
# }

module "global_accelerator" { 
  source = "../.."
  ganame = var.name # need to verify if canbe passed as a varible
  ip_address_type     = "IPV4"
  flow_logs_enabled   = false
  # flow_logs_s3_prefix = "logs/"
  # flow_logs_s3_bucket = module.s3_bucket.bucket_id
  listeners = [
    {
      client_affinity = "NONE"
      protocol        = "TCP"
      port_ranges = [
        {
          from_port = var.alb_listener_port
          to_port   = var.alb_listener_port
        }
      ]
    }
  ]
}

module "endpoint_group" {
  source = "../../modules/endpoint-group"
  listener_arn = module.global_accelerator.listener_ids[0]
  config = {
    endpoint_region = var.region
    # # endpoint_configuration = [
    # #   {
    # #     #endpoint_lb_name = module.alb.alb_name     #Pass the nlb name from load balancer module.
    # #   }
    # ] 
  }
}