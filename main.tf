provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_lambda_layer_version" "requests_layer" {
  layer_name          = "requests_layer"
  compatible_runtimes = ["python3.10"]
  filename            = "lambda_layers/requests_layer.zip"
}

module "lambda" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "7.8.1"

  function_name = "lambda_function"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.10"

  source_path = "lambda/lambda_function.py"

  layers = [aws_lambda_layer_version.requests_layer.arn]
}
