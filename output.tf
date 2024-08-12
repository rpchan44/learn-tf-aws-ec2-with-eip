output "instance_id" {
  value       = aws_instance.RealServer-01.id
  description = "Ec2 instance id"
}

output "public_ip" {
  value       = aws_instance.RealServer-01.public_ip
  description = "Ec2 public ip"
}
