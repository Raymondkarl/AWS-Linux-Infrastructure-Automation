terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"               # this will use the latest version of the AWS provider in the 6.x series
    }
  }
      backend "s3" {                  # this configures Terraform to use an S3 bucket for storing the state file
    bucket = "raymond-project2"
    key    = "project2/ec2/terraform.tfstate"
    region = "ap-southeast-1"
  }  
}

provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_instance" "linux_server" {
  ami                    = "ami-02dd44faa40720bb8"
  instance_type          = "t3.micro"
  subnet_id              = "subnet-05d296f4de46b4052"
  vpc_security_group_ids = ["sg-08908c4b30b901f36"]
  key_name               = "linuxserver"
  associate_public_ip_address = true

  tags = {
    Name = "linux_server"
    Environment = "Development"
    Project = "AWS Linux Infrastructure Automation"
    ManagedBy = "Terraform"
  }
}