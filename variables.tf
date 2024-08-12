variable "region" {
  description = "The AWS region to deploy to"
  type        = string
  default     = "ap-southeast-1"
}
variable "any_network" {
  description = "0.0.0.0/0 global internet"
  type        = string
  default     = "0.0.0.0/0"
}
variable "vpc_cidr_block" {
  description = "VPC subnet block /16"
  type        = string
  default     = "10.0.0.0/16"
}
variable "apps01_subnet_cidr_block" {
  description = "Apps01 subnet /24"
  type        = string
  default     = "10.0.1.0/24"
}
variable "apps01_devel_private_ip" {
  description = "Private ip"
  type        = string
  default     = "10.0.1.5"
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
