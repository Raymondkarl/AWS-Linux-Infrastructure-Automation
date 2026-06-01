resource "aws_s3_bucket" "terraform_state" {
  bucket = var.bucket_name

  tags = {
    Name        = "linux-server-terraform-bucket"
    Environment = "Development"
    Project     = "demo"
    ManagedBy   = "Terraform"
  }
}