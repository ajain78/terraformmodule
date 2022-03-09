region = "us-east-1"

namespace = "eg"

environment = "gbl"

stage = "test"

name = "globalacc-multi-region"

alb_listener_port = 80

availability_zones = ["us-east-1a", "us-east-1d"]

failover_region = "us-west-1"

failover_availability_zones = ["us-west-1a", "us-west-1b"]