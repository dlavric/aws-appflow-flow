terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.23.1"
    }
  }
}

provider "aws" {
 region = "eu-west-1"
}

resource "aws_s3_bucket" "example_source" {
  bucket = "daniela-source"
}


data "aws_iam_policy_document" "example_source" {
  statement {
    sid    = "AllowAppFlowSourceActions"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["appflow.amazonaws.com"]
    }

    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:PutObject",
      "s3:GetBucketAcl",
      "s3:PutObjectAcl"
    ]

    resources = [
      "arn:aws:s3:::daniela-source",
      "arn:aws:s3:::daniela-source/*"
    ]
  }
}

resource "aws_s3_bucket_policy" "example_source" {
  bucket = aws_s3_bucket.example_source.id
  policy = data.aws_iam_policy_document.example_source.json
}
resource "aws_s3_object" "example" {
  bucket = aws_s3_bucket.example_source.id
  key    = "daniela_source.csv"
  source = "daniela_source.csv"
}

resource "aws_s3_bucket" "example_destination" {
  bucket = "daniela-destination"
}

data "aws_iam_policy_document" "example_destination" {
  statement {
    sid    = "AllowAppFlowSourceActions"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["appflow.amazonaws.com"]
    }

    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:PutObject",
      "s3:GetBucketAcl",
      "s3:PutObjectAcl"
    ]

    resources = [
      "arn:aws:s3:::daniela-destination",
      "arn:aws:s3:::daniela-destination/*"
    ]
  }
}

resource "aws_s3_bucket_policy" "example_destination" {
  bucket = aws_s3_bucket.example_destination.id
  policy = data.aws_iam_policy_document.example_destination.json
}



resource "aws_appflow_flow" "example" {
  name = "example"

  source_flow_config {
    connector_type = "S3"
    source_connector_properties {
      s3 {
        bucket_name   = aws_s3_bucket.example_source.bucket
        bucket_prefix = aws_s3_bucket.example_source.bucket_prefix
      }
    }
  }

  destination_flow_config {
    connector_type = "S3"

    destination_connector_properties {
      s3 {
        bucket_name   = aws_s3_bucket.example_destination.bucket
        bucket_prefix = aws_s3_bucket.example_destination.bucket_prefix
        s3_output_format_config {
          file_type = "JSON"
          aggregation_config {
            aggregation_type = "None"
          }
        }
      }
    }
  }

  task {
    source_fields     = ["exampleField"]
    destination_field = "exampleField"
    task_type         = "Map"

    connector_operator {
      s3 = "NO_OP"
    }
  }

  trigger_config {
    trigger_type = "OnDemand"
  }
}
