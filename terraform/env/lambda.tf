######################################################

module "import_from_raw_to_intermediate_departments" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "3.3.0"

  source_path            = "${path.module}/lambdas/import_table_departments/"
  function_name          = "import_table_departments_to_intermediate"
  description            = "Process file from S3 raw bucket and import into intermediate table"
  handler                = "index.lambda_handler"
  runtime                = "python3.9"
  lambda_role            = aws_iam_role.import_from_raw_to_intermediate.arn
  architectures          = ["x86_64"]
  create_role            = false
  create_package         = true
  publish                = true
  timeout                = 600
  memory_size            = 1024
  ephemeral_storage_size = 1024
  environment_variables = {
    DATABASE_NAME   = "intermediate_db"
    S3_PATH         = "${module.s3_bucket_raw.s3_bucket_id}/departments/"
    TABLE_NAME      = "departments"
  }
  layers = [
    "arn:aws:lambda:us-east-1:336392948345:layer:AWSSDKPandas-Python39:12"
  ]

  tags = var.tags
}

resource "aws_lambda_permission" "allow_sns_to_execute_lambda_intermediate_departments" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = module.import_from_raw_to_intermediate_departments.lambda_function_arn
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.replication_raw_topic.arn
}

######################################################

module "import_from_raw_to_intermediate_jobs" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "3.3.0"

  source_path            = "${path.module}/lambdas/import_table_jobs/"
  function_name          = "import_table_departments_to_intermediate"
  description            = "Process file from S3 raw bucket and import into intermediate table"
  handler                = "index.lambda_handler"
  runtime                = "python3.9"
  lambda_role            = aws_iam_role.import_from_raw_to_intermediate.arn
  architectures          = ["x86_64"]
  create_role            = false
  create_package         = true
  publish                = true
  timeout                = 600
  memory_size            = 1024
  ephemeral_storage_size = 1024
  environment_variables = {
    DATABASE_NAME   = "intermediate_db"
    S3_PATH         = "${module.s3_bucket_raw.s3_bucket_id}/jobs/"
    TABLE_NAME      = "jobs"
  }
  layers = [
    "arn:aws:lambda:us-east-1:336392948345:layer:AWSSDKPandas-Python39:12"
  ]

  tags = var.tags
}

resource "aws_lambda_permission" "allow_sns_to_execute_lambda_intermediate_jobs" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = module.import_from_raw_to_intermediate_jobs.lambda_function_arn
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.replication_raw_topic.arn
}

######################################################

module "import_from_raw_to_intermediate_hired_employees" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "3.3.0"

  source_path            = "${path.module}/lambdas/import_table_departments/"
  function_name          = "import_table_departments_to_intermediate"
  description            = "Process file from S3 raw bucket and import into intermediate table"
  handler                = "index.lambda_handler"
  runtime                = "python3.9"
  lambda_role            = aws_iam_role.import_from_raw_to_intermediate.arn
  architectures          = ["x86_64"]
  create_role            = false
  create_package         = true
  publish                = true
  timeout                = 600
  memory_size            = 1024
  ephemeral_storage_size = 1024
  environment_variables = {
    DATABASE_NAME   = "intermediate_db"
    S3_PATH         = "${module.s3_bucket_raw.s3_bucket_id}/hired_employees/"
    TABLE_NAME      = "hired_employees"
  }
  layers = [
    "arn:aws:lambda:us-east-1:336392948345:layer:AWSSDKPandas-Python39:12"
  ]

  tags = var.tags
}

resource "aws_lambda_permission" "allow_sns_to_execute_lambda_intermediate_hired_employees" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = module.import_from_raw_to_intermediate_hired_employees.lambda_function_arn
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.replication_raw_topic.arn
}