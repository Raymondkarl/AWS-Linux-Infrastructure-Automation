terraform {
  backend "s3" {
    bucket = "raymond-project"
    key    = "project/ec2/terraform.tfstate"
    region = "ap-southeast-1"
  }
}