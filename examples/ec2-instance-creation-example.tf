terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "~> 4.0"
      }
    }
}

variable "region" {
    default = "us-east-1"
}

provider "aws" {
    region = "us-east-1"
}

data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_instance" "test" {
  ami = data.aws_ami.amzn-linux-2023-ami.id
  instance_type = "t3.nano"

  tags = {
    Name = "TestInstance"
  }
}