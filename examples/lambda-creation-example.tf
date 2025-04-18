terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "~> 4.0"
      }
    }
}

variable "region" {
    default = "us-east-1"
}

provider "aws" {
    region = "us-east-1"
}

data "archive_file" "tf-lambda-file" {
  type = "zip"
  source_dir  = "${path.module}/lambda"
  output_path = "${path.module}/tf-lambda.zip"
}

resource "aws_s3_bucket" "test-tf-bucket-2" {
  bucket = "wingma-tf-bucket-2"
}

resource "aws_s3_object" "tf-demo-upload" {
  bucket = aws_s3_bucket.test-tf-bucket-2.id
  key    = "tf-lambda.zip"
  source = data.archive_file.tf-lambda-file.output_path
  etag = filemd5(data.archive_file.tf-lambda-file.output_path)
}

resource "aws_lambda_function" "hello_wing" {
  function_name = "HelloWing"

  s3_bucket = aws_s3_bucket.test-tf-bucket-2.id
  s3_key    = aws_s3_object.tf-demo-upload.key

  runtime = "python3.9"
  handler = "hello.handler"

  source_code_hash = data.archive_file.tf-lambda-file.output_base64sha256

  role = aws_iam_role.lambda_exec.arn
}

resource "aws_cloudwatch_log_group" "hello_world" {
  name = "/aws/lambda/${aws_lambda_function.hello_wing.function_name}"

  retention_in_days = 30
}

resource "aws_iam_role" "lambda_exec" {
  name = "serverless_lambda"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}