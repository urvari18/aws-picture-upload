# DevOps Image Upload to S3 via API

##  Prerequisites

- AWS CLI configured (`aws configure`)
- Terraform installed
- Python 3.9+ (for Lambda packaging)
- IAM user with permissions to create Lambda, VPC, S3, API Gateway, IAM roles

## Project Structure

devops-image-upload/
├── lambda/
│   └── handler.py         # Python code for Lambda
├── terraform/
│   ├── main.tf            # VPC, S3 setup
│   ├── lambda.tf          # Lambda + API Gateway
│   ├── variables.tf       # Optional variables
│   ├── outputs.tf         # Shows endpoint + bucket name
└── README.md              # This file!


## Package the Lambda Code
- **Command**: Compress-Archive -Path .\lambda\* -DestinationPath .\terraform\lambda.zip -Force

## Deploy with Terraform
- cd terraform
- terraform init
- terraform apply

## Upload an Image
Use curl to send an image to the API:
- **Command**: curl -X POST \
  -H "Content-Type: application/octet-stream" \
  --data-binary "@abc.jpg" \
  https://<api_endpoint>/upload

## How It Works
- API Gateway receives the image
- Lambda decodes it and saves it to S3 with a unique name
- The image lands in your bucket, safe and sound

## Security Notes
- Lambda runs inside a private VPC
- IAM roles are scoped to only allow necessary actions (S3 write, EC2 network interface, logs)
- S3 bucket is private by default

  
