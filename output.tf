output "instance_id" {
  value       = aws_instance.RealServer-01.id
  description = "The ID of the EC2 instance"
}

output "public_dns" {
  value       = aws_instance.RealServer-01.public_dns
  description = "The public DNS name of the EC2 instance"
}
