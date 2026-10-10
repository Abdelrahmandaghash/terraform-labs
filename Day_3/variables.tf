


variable "environment" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "azs" {
  type        = list(string)
}

variable "public_subnet_cidrs" {
  type        = list(string)
}

variable "private_subnet_cidrs" {
  type        = list(string)
}

variable "ami_id" {
  type = string
}

variable "web_instances" {
  type = map(object({
    az = string
  }))
}

variable "backend_instances" {
  type = map(object({
    az = string
  }))
}