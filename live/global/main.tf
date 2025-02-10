provider "aws"{
    region = "ca-central-1"
    profile = "personal-account"
}

resource "aws_s3_bucket" "terraform-state" {
    bucket = "terraform-state-microservices-group-f"
    force_destroy = true

    tags = {
      Name = "Terraform State"
      Environment = "Global"
    }
}

resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.terraform-state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.terraform-state.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_policy" "terraform_state_policy" {
  bucket = aws_s3_bucket.terraform-state.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Deny",
        Principal = "*",
        Action = "s3:*",
        Resource = [
          "${aws_s3_bucket.terraform-state.arn}",
          "${aws_s3_bucket.terraform-state.arn}/*"
        ],
        Condition = {
          Bool = {
            "aws:SecureTransport": "false"
          }
        }
      }
    ]
  })
}

resource "aws_s3_bucket_public_access_block" "default" {
  bucket = aws_s3_bucket.terraform-state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


resource "aws_dynamodb_table" "terraform-locks" {
  name           = "terraform-state-microservices-group-f-lock"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    Name = "Terraform Locks"
    Environment = "Global"
  }
}

# terraform {
#   backend "s3" {
#     bucket = "terraform-state-microservices-group-f"
#     key = "global/s3/terraform.tfstate"
#     region = "us-west-2"

#     dynamodb_table = "terraform-state-microservices-lock"
#     encrypt = true
#   }
# }