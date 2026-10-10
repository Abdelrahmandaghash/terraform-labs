environment  = "prod"
vpc_cidr     = "10.2.0.0/16"

azs = ["us-east-1a", "us-east-1b", "us-east-1c"]

public_subnet_cidrs  = ["10.2.0.0/24", "10.2.2.0/24", "10.2.4.0/24"]
private_subnet_cidrs = ["10.2.1.0/24", "10.2.3.0/24", "10.2.5.0/24"]

web_instances = {
  web_a = { az = "us-east-1a" }
  web_b = { az = "us-east-1b" }
  web_c = { az = "us-east-1c" }
}

backend_instances = {
  backend_a = { az = "us-east-1a" }
  backend_b = { az = "us-east-1b" }
  backend_c = { az = "us-east-1c" }
}

ami_id = "ami-0c55b159cbfafe1f0"