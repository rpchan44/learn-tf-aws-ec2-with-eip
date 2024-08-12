variable "region" {
  description = "The AWS region to deploy to"
  type        = string
  default     = "ap-southeast-1"
}
variable "ubuntu-ami" {
  description = "Ubuntu AMI for ap-southeast-1a"
  type        = string
  default     = "ami-060e277c0d4cce553"
}
variable "ami_availability_zone" {
  description = "Availability Zone"
  type        = string
  default     = "ap-southeast-1a"
}
variable "instance_type" {
  description = "The type of EC2 instance"
  type        = string
  default     = "t2.micro"
}
variable "devel_ssh_key_pairs" {
  description = "Development Keypair"
  type        = string
  default     = "Development"
}
variable "prod_ssh_key_pairs" {
  description = "Production Keypair"
  type        = string
  default     = "Production"
}
