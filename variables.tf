variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "vpc_id" {
  type        = string
  description = "Provide VPC Id"
}

