output "instance_public_ip" {
  description = "Public IP of the billing app instance"
  value       = aws_eip.billing_app.public_ip
}

output "instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.billing_app.id
}

output "s3_bucket_name" {
  description = "S3 bucket for invoices"
  value       = aws_s3_bucket.billing_invoices.id
}

output "security_group_id" {
  description = "Security Group ID"
  value       = aws_security_group.billing_app.id
}

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "ssh_command" {
  description = "SSH command to connect"
  value       = "ssh -i ~/.ssh/id_rsa ubuntu@${aws_eip.billing_app.public_ip}"
}

output "api_url" {
  description = "API URL"
  value       = "https://${aws_eip.billing_app.public_ip}"
}
