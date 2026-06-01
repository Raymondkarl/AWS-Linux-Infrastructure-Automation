resource "aws_s3_bucket" "terraform_state" {
  bucket = var.bucket_name

  tags = {
    Name      = var.bucket_name
    Environment = "Development"
    Project     = "demo"
    ManagedBy = "Terraform"
  }
}
