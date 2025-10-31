# Optional: Store state in S3 (for team collaboration)
# Uncomment after first apply to migrate state

# terraform {
#   backend "s3" {
#     bucket         = "billing-app-terraform-state"
#     key            = "production/terraform.tfstate"
#     region         = "ap-south-1"
#     encrypt        = true
#     dynamodb_table = "terraform-locks"
#   }
# }
