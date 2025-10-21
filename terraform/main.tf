provider "aws" {
  region = "eu-west-2" # London
}

resource "aws_s3_bucket" "image_bucket" {
  bucket = "devops-image-upload-${random_id.bucket_id.hex}"
  acl    = "private"

  tags = {
    Name = "ImageUploadBucket"
  }
}

resource "random_id" "bucket_id" {
  byte_length = 4
}

resource "aws_vpc" "private_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "PrivateVPC"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.private_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-2a"
  tags = {
    Name = "PrivateSubnet"
  }
}

resource "aws_security_group" "lambda_sg" {
  name        = "lambda-sg"
  description = "Allow Lambda access"
  vpc_id      = aws_vpc.private_vpc.id
}
