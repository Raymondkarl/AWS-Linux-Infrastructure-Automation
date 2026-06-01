resource "aws_instance" "demo-101" {
  ami                         = var.ami_value
  instance_type               = var.instance_type_value
  subnet_id                   = var.subnet_id_value
  vpc_security_group_ids      = var.vpc_security_group_ids_value
  key_name                    = var.key_name_value
  associate_public_ip_address = true

  # Enable detailed CloudWatch monitoring
  monitoring = true

  # Configure EBS root volume
  root_block_device {
    volume_size = 8
    volume_type = "gp3"
    encrypted   = true
  }

  # Resource tags
  tags = {
    Name        = "demo-101"
    Environment = "dev"
    Project     = "demo"
    ManagedBy   = "terraform"
  }
}