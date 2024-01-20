variable "function_name_suffix" {}
variable "runtime" {}
variable "layers" {}
variable "execution_role_arn" {}

data "archive_file" "lambda" {
  type        = "zip"
  source_dir  = "../../../python"
  output_path = "./python.zip"
}

resource "aws_lambda_function" "main" {
  function_name    = "cm-nakamura-lambda-${var.function_name_suffix}"
  handler          = "lambda_handler.lambda_handler"
  runtime          = var.runtime
  filename         = data.archive_file.lambda.output_path
  source_code_hash = data.archive_file.lambda.output_base64sha256
  role             = var.execution_role_arn
  timeout          = 600
  layers           = var.layers
}
