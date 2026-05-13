terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"               # this will use the latest version of the AWS provider in the 6.x series
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "raymond-project2"

  tags = {
    Name        = "linux-server-terraform-bucket"
    Environment = "Development"
  }
}