terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = "gg"
  secret_key = "dmx"

  endpoints {
    ec2   = "http://localhost:4566"
    elb   = "http://localhost:4566"
    elbv2 = "http://localhost:4566"
  }

  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
}
