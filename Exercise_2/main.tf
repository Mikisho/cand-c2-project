provider "aws" {
  region = var.region
}

# Lambda Function Provisioning 
data "archive_file" "lambda_file" {
    type = "zip"
    source_file = "greet_lambda.py"
    output_path = "var.lambda_function"

}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "python_lambda_fun" {
  filename = "var.lambda_function"
  function_name = var.lambda_fun_name
  handler = "greet_lambda.lambda_handler"
  runtime = "python3.8"
  role = aws_iam_role.iam_for_lambda.arn

  environment{
      variables = {
          greeting = "Hello"
      }
  }

  tags = {
      Project = "Udacity_AWS_Proj2"
  }

  depends_on = [aws_iam_role_policy_attachment.lambda_logs, aws_cloudwatch_log_group.udacity_lambda]
}

# Cloud watch provision
resource "aws_cloudwatch_log_group" "udacity_lambda" {
  name              = "/aws/lambda/${var.lambda_fun_name}"
  retention_in_days = 14
}

# AWS managed policy: AWSLambdaExecutionRole
resource "aws_iam_policy" "lambda_logging" {
  name        = "lambda_logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = "${aws_iam_role.iam_for_lambda.name}"
  policy_arn = "${aws_iam_policy.lambda_logging.arn}"
}