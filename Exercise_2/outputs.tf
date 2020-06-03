# TODO: Define the output variable for the lambda function.
output "lambda_iam_role"{
    description = "IAM ARN for Lambda Function"
    value = "${aws_iam_role.iam_for_lambda}"
}

output "lambda_arn"{
    description = "ARN of Udacity Lambda Function"
    value = "${aws_lambda_function.python_lambda_fun}"
}