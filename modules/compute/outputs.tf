output "ec2_ip" {
  description = "Details of the Instance"
  value       = aws_instance.webserver.public_ip
}