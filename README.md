Terraform module to provision an EC2 instance running apache.

Not intended for production use.

Just testing how to create a custom module in the Terraform registry.



   
    provider "aws" {
      region = "us-east-1"
    }
       
    locals {
      project_name = "Project-"
    }
    
    data "template_file" "user_data" {
      template = file("${abspath(path.module)}/userdata.yaml")
    }
    
    data "aws_vpc" "main" {
      id = var.vpc_id
    }
    
    resource "aws_instance" "app_server" {
      ami                    = data.aws_ami.amazon-linux-2.id
      instance_type          = var.instance_type
      key_name               = "web-servers-key-pair"
      vpc_security_group_ids = ["SG-ID"]
      user_data              = data.template_file.user_data.rendered
    
      tags = {
        Name = "${local.project_name}AppServerInstance"
      }
    
    }
    
    data "aws_ami" "amazon-linux-2" {
      most_recent = true
      owners      = ["amazon"]
    
      filter {
        name   = "owner-alias"
        values = ["amazon"]
      }
    
      filter {
        name   = "name"
        values = ["amzn2-ami-hvm*"]
      }
    
    }
