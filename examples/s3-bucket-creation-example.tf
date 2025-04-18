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

resource "aws_s3_bucket" "test-tf-bucket-2g" {
  bucket = "wingma-tf-bucket-2"
}
