resource "aws_sns_topic" "replication_raw_topic" {
  name = "replication_raw"
}

resource "aws_sns_topic_policy" "default" {
  arn = aws_sns_topic.replication_raw_topic.arn

  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

data "aws_iam_policy_document" "sns_topic_policy" {
  policy_id = "__default_policy_ID"

  statement {
    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission",
    ]

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      aws_sns_topic.replication_raw_topic.arn,
    ]

    sid = "__default_statement_ID"
  }
}

resource "aws_sns_topic_subscription" "topic_replication_departments_to_intermediate" {
  topic_arn = aws_sns_topic.replication_raw_topic.arn
  protocol  = "lambda"
  endpoint  = module.import_from_raw_to_intermediate_departments.lambda_function_arn
}

resource "aws_sns_topic_subscription" "topic_replication_jobs_to_intermediate" {
  topic_arn = aws_sns_topic.replication_raw_topic.arn
  protocol  = "lambda"
  endpoint  = module.import_from_raw_to_intermediate_jobs.lambda_function_arn
}

resource "aws_sns_topic_subscription" "topic_replication_hired_employees_to_intermediate" {
  topic_arn = aws_sns_topic.replication_raw_topic.arn
  protocol  = "lambda"
  endpoint  = module.import_from_raw_to_intermediate_hired_employees.lambda_function_arn
}


resource "aws_s3_bucket_notification" "aws_bucket_notification" {
  bucket = data.aws_s3_bucket.s3_bucket_raw.id

  topic {
    topic_arn     = aws_sns_topic.replication_raw_topic.arn
    events        = ["s3:ObjectCreated:*"]
    filter_suffix = ".csv"
  }
}
