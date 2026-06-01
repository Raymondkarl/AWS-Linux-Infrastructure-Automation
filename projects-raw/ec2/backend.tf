terraform {
  backend "s3" {
    bucket = "raymond-project2"
    key    = "project2/ec2/terraform.tfstate"
    region = "ap-southeast-1"
  }
}