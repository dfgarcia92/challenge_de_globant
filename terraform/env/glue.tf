### Staging Databases ###

resource "aws_glue_catalog_database" "intermediate_database" {

  name         = "intermediate_db"
  location_uri = "s3://${data.s3_bucket_intermediate_name}/"
  description  = "Intermediate database created by terraform"

  create_table_default_permission {
    permissions = ["ALL"]

    principal {
      data_lake_principal_identifier = "IAM_ALLOWED_PRINCIPALS"
    }
  }
}