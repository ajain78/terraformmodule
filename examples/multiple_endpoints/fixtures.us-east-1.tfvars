region = "us-east-1"

namespace = "eg"

environment = "gbl"

stage = "test"

name = "acc"

alb_listener_port = 80

availability_zones = ["us-east-1a", "us-east-1b"]

vpc_cidr_block = "10.0.0.0/16"

failover_region = "us-east-1"

failover_vpc_cidr_block = "10.0.0.0/16"

failover_availability_zones = ["us-east-1a", "us-east-1b"]

profile = [""]
