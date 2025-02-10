# terraform {
#   backend "s3" {
#     bucket         = "your-global-terraform-state-bucket" # Replace with your bucket name
#     key            = "production/terraform.tfstate"
#     region         = "ca-central-1"
#     dynamodb_table = "your-terraform-lock-table"         # Replace with your DynamoDB table name
#     encrypt        = true
#   }
# }