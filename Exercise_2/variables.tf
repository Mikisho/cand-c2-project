# TODO: Define the variable for aws_region
variable "region" {
  default = "us-east-1"
}
variable "lambda_function" {
  default = "dev_package/greet_lambda.zip"
}

variable "lambda_fun_name" {
  default = "serverless_greet_lambda"
}
