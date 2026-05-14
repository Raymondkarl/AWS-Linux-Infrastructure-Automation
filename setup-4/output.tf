output "public_ip" {
  value = aws_instance.linux_server.public_ip
}

output "ssh_command" {
  value = "ssh -i linuxserver.pem ubuntu@${aws_instance.linux_server.public_ip}"
}
