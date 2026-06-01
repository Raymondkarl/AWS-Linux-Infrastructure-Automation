output "public_ip-address" {
  value = aws_instance.demo-101.public_ip
}

output "ssh_command" {
  value = "ssh -i linuxserver.pem ubuntu@${aws_instance.demo-101.public_ip}"
}