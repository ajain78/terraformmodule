provider "aws" {
  region = var.region
}

# module "s3_bucket" {
#   source  = "../.." #put the s3 source from different module
#   force_destroy = true
# }

module "alb" {
  source  = "../.." #put the s3 source from different module
  force_destroy = true
}

module "global_accelerator" {
  source = "../.."
  ip_address_type     = "IPV4"
  # flow_logs_enabled   = true
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
    endpoint_configuration = [
      {
        endpoint_lb_name = module.alb.alb_name
      }
    ]
  }
}
