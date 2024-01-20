

#-----------------------------
# IAMロール
#-----------------------------
resource "aws_iam_role" "lambda_execution_role" {
  name               = "cm-nakamura-lambda-execution-role"
  assume_role_policy = <<-EOT
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
    EOT

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  ]
}

#-----------------------------
# Custom Lambda Layer
#-----------------------------
# data "external" "example" {
#   program = ["bash", "build_lambda_layer.sh"]
# }

data "archive_file" "lambda_layer" {
  type        = "zip"
  source_dir  = "lambda_layer"
  output_path = "lambda_layer.zip"
}

resource "aws_lambda_layer_version" "lambda_layer" {
  layer_name       = "cm-nakamura-python-layer-setuptools"
  filename         = data.archive_file.lambda_layer.output_path
  source_code_hash = data.archive_file.lambda_layer.output_base64sha256
}

#-----------------------------
# Lamda
#-----------------------------
module "lambda_py312" {
  source               = "../../modules/lambda"
  function_name_suffix = "py312"
  runtime              = "python3.12"
  layers               = [aws_lambda_layer_version.lambda_layer.arn]
  execution_role_arn   = aws_iam_role.lambda_execution_role.arn
}

module "lambda_py311" {
  source               = "../../modules/lambda"
  function_name_suffix = "py311"
  runtime              = "python3.11"
  layers               = []
  execution_role_arn   = aws_iam_role.lambda_execution_role.arn
}

module "lambda_py310" {
  source               = "../../modules/lambda"
  function_name_suffix = "py310"
  runtime              = "python3.10"
  layers               = []
  execution_role_arn   = aws_iam_role.lambda_execution_role.arn
}

module "lambda_py39" {
  source               = "../../modules/lambda"
  function_name_suffix = "py39"
  runtime              = "python3.9"
  layers               = []
  execution_role_arn   = aws_iam_role.lambda_execution_role.arn
}

module "lambda_py38" {
  source               = "../../modules/lambda"
  function_name_suffix = "py38"
  runtime              = "python3.8"
  layers               = []
  execution_role_arn   = aws_iam_role.lambda_execution_role.arn
}

module "lambda_py37" {
  source               = "../../modules/lambda"
  function_name_suffix = "py37"
  runtime              = "python3.7"
  layers               = []
  execution_role_arn   = aws_iam_role.lambda_execution_role.arn
}

#-----------------------------
# Lambda + Lambda Power Tools
#-----------------------------
module "lambda_py312_powertools" {
  source               = "../../modules/lambda"
  function_name_suffix = "py312_powertools"
  runtime              = "python3.12"
  layers = [
    aws_lambda_layer_version.lambda_layer.arn,
    "arn:aws:lambda:ap-northeast-1:017000801446:layer:AWSLambdaPowertoolsPythonV2:60"
  ]
  execution_role_arn = aws_iam_role.lambda_execution_role.arn
}

module "lambda_py311_powertools" {
  source               = "../../modules/lambda"
  function_name_suffix = "py311_powertools"
  runtime              = "python3.11"
  layers               = ["arn:aws:lambda:ap-northeast-1:017000801446:layer:AWSLambdaPowertoolsPythonV2:60"]
  execution_role_arn   = aws_iam_role.lambda_execution_role.arn
}

module "lambda_py37_powertools" {
  source               = "../../modules/lambda"
  function_name_suffix = "py37_powertools"
  runtime              = "python3.7"
  layers               = ["arn:aws:lambda:ap-northeast-1:017000801446:layer:AWSLambdaPowertoolsPythonV2:60"]
  execution_role_arn   = aws_iam_role.lambda_execution_role.arn
}

#-----------------------------
# Lamda + AWS SDK for Pandas
#-----------------------------
module "lambda_py312_sdkpandas" {
  source               = "../../modules/lambda"
  function_name_suffix = "py312_sdkpandas"
  runtime              = "python3.12"
  layers = [
    aws_lambda_layer_version.lambda_layer.arn,
    "arn:aws:lambda:ap-northeast-1:336392948345:layer:AWSSDKPandas-Python312:2"
  ]
  execution_role_arn = aws_iam_role.lambda_execution_role.arn
}

module "lambda_py311_sdkpandas" {
  source               = "../../modules/lambda"
  function_name_suffix = "py311_sdkpandas"
  runtime              = "python3.11"
  layers               = ["arn:aws:lambda:ap-northeast-1:336392948345:layer:AWSSDKPandas-Python311:6"]
  execution_role_arn   = aws_iam_role.lambda_execution_role.arn
}

module "lambda_py310_sdkpandas" {
  source               = "../../modules/lambda"
  function_name_suffix = "py310_sdkpandas"
  runtime              = "python3.10"
  layers               = ["arn:aws:lambda:ap-northeast-1:336392948345:layer:AWSSDKPandas-Python310:9"]
  execution_role_arn   = aws_iam_role.lambda_execution_role.arn
}

module "lambda_py39_sdkpandas" {
  source               = "../../modules/lambda"
  function_name_suffix = "py39_sdkpandas"
  runtime              = "python3.9"
  layers               = ["arn:aws:lambda:ap-northeast-1:336392948345:layer:AWSSDKPandas-Python39:14"]
  execution_role_arn   = aws_iam_role.lambda_execution_role.arn
}

module "lambda_py38_sdkpandas" {
  source               = "../../modules/lambda"
  function_name_suffix = "py38_sdkpandas"
  runtime              = "python3.8"
  layers               = ["arn:aws:lambda:ap-northeast-1:336392948345:layer:AWSSDKPandas-Python38:14"]
  execution_role_arn   = aws_iam_role.lambda_execution_role.arn
}

module "lambda_py37_sdkpandas" {
  source               = "../../modules/lambda"
  function_name_suffix = "py37_sdkpandas"
  runtime              = "python3.7"
  layers               = ["arn:aws:lambda:ap-northeast-1:336392948345:layer:AWSSDKPandas-Python37:5"]
  execution_role_arn   = aws_iam_role.lambda_execution_role.arn
}

#-----------------------------
# Lamda + SciPy
#-----------------------------
module "lambda_py38_scipy" {
  source               = "../../modules/lambda"
  function_name_suffix = "py38_scipy"
  runtime              = "python3.8"
  layers               = ["arn:aws:lambda:ap-northeast-1:249908578461:layer:AWSLambda-Python38-SciPy1x:109"]
  execution_role_arn   = aws_iam_role.lambda_execution_role.arn
}

module "lambda_py37_scipy" {
  source               = "../../modules/lambda"
  function_name_suffix = "py37_scipy"
  runtime              = "python3.7"
  layers               = ["arn:aws:lambda:ap-northeast-1:249908578461:layer:AWSLambda-Python37-SciPy1x:118"]
  execution_role_arn   = aws_iam_role.lambda_execution_role.arn
}
