variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"  # Free tier eligible
}

variable "public_key_path" {
  description = "Path to SSH public key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "ssh_allowed_cidr" {
  description = "CIDR block allowed for SSH"
  type        = list(string)
  default     = ["0.0.0.0/0"]  # ⚠️ Change to your IP
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "production"
}
