######## Role for import_from_raw_to_intermediate ########

data "aws_iam_policy_document" "import_from_raw_to_intermediate" {

  statement {
    sid = "ReadRawS3"

    actions = [
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:ListBucket",
      "s3:GetObjectVersion"
    ]

    resources = [
      module.s3_bucket_raw.s3_bucket_arn,
      "${module.s3_bucket_raw.s3_bucket_arn}/*"
    ]

  }

  statement {
    sid = "ReadWriteS3Intermediate"

    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:PutObjectAcl",
      "s3:GetObjectAcl",
      "s3:ListBucket",

    ]

    resources = [
      module.s3_bucket_intermediate.s3_bucket_arn,
      "${module.s3_bucket_intermediate.s3_bucket_arn}/*"
    ]

  }

}

# Create role with the trust relationship
resource "aws_iam_role" "import_from_raw_to_intermediate" {
  name               = "import_from_raw_to_intermediate_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_lambda.json
  tags               = var.tags
}

resource "aws_iam_policy" "import_from_raw_to_intermediate" {
  name   = "import_from_raw_to_intermediate_policy"
  policy = data.aws_iam_policy_document.import_from_raw_to_intermediate.json
}

resource "aws_iam_role_policy_attachment" "import_from_raw_to_intermediate" {
  role       = aws_iam_role.import_from_raw_to_intermediate.name
  policy_arn = aws_iam_policy.import_from_raw_to_intermediate.arn
}

resource "aws_iam_role_policy_attachment" "allow_put_logs_import_from_raw_to_intermediate" {
  role       = aws_iam_role.import_from_raw_to_intermediate.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "kms_key_usage_import_from_raw_to_intermediate" {
  role       = aws_iam_role.import_from_raw_to_intermediate.name
  policy_arn = aws_iam_policy.kms_key_usage.arn
}
