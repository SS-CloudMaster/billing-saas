aws_region       = "ap-south-1"
instance_type    = "t3.micro"
public_key_path  = "~/.ssh/billing-app-public_key.pub"
environment      = "production"
ssh_allowed_cidr = ["20.192.21.50/32"]  # Replace with your IP