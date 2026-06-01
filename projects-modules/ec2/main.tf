resource "aws_instance" "demo-101" {
  ami                    = "ami-02dd44faa40720bb8"
  instance_type          = "t3.micro"
  subnet_id              = "subnet-05d296f4de46b4052"
  vpc_security_group_ids = ["sg-08908c4b30b901f36"]
  key_name               = "linuxserver"

  tags = {
    Name        = "demo-100000"
    Environment = "dev"
    Project     = "demo"
    ManagedBy   = "terraform"
  }
}
