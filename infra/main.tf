# Intentionally insecure Terraform for Upwind IaC PR-block demo — DO NOT APPLY

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "demo_public" {
  bucket = "upwind-pr-block-demo-public-do-not-use"
  # public / insecure patterns for IaC rules
  acl    = "public-read"
}

resource "aws_s3_bucket_public_access_block" "demo_public" {
  bucket = aws_s3_bucket.demo_public.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_security_group" "wide_open" {
  name        = "upwind-pr-block-demo-wide-open"
  description = "Intentionally open SG for IaC demo"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "demo" {
  identifier           = "upwind-pr-block-demo-db"
  engine               = "mysql"
  instance_class       = "db.t3.micro"
  allocated_storage    = 20
  username             = "admin"
  password             = "SuperSecretPassword123!" # hardcoded secret pattern
  publicly_accessible  = true
  skip_final_snapshot  = true
  storage_encrypted    = false
}

resource "aws_iam_policy" "admin_like" {
  name = "upwind-pr-block-demo-admin"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = "*"
      Resource = "*"
    }]
  })
}

resource "aws_instance" "open_ssh" {
  ami           = "ami-0abcdef1234567890"
  instance_type = "t3.micro"

  associate_public_ip_address = true

  metadata_options {
    http_tokens = "optional" # IMDSv1 allowed
  }

  user_data = <<-EOT
    #!/bin/bash
    echo "password=SuperSecret123" > /tmp/creds.txt
  EOT
}
