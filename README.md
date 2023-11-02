# aws-appflow-flow
This repository is creating an aws_appflow_flow resource with the AWS provider


## Pre-requisites

- [X] [Terraform](https://www.terraform.io/downloads)
- [X] [AWS Account](https://aws.amazon.com/resources/create-account/)

## Steps on how to use this repository

- Clone this repository:
```shell
git clone https://github.com/dlavric/aws-appflow-flow.git
```

- Go to the directory where the repo is stored:
```shell
cd aws-appflow-flow
```


- Export your AWS Keys on your terminal
```shell
export AWS_REGION="us-west-1"
export AWS_ACCESS_KEY_ID=...
export AWS_SECRET_ACCESS_KEY=...
export AWS_SESSION_TOKEN=...                  
```

- Initialize Terraform to download the providers and the modules
```shell
terraform init

Initializing the backend...

Initializing provider plugins...
- Reusing previous version of hashicorp/aws from the dependency lock file
- Using previously-installed hashicorp/aws v5.23.1

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

- Apply the changes to create the infrastructure
```shell
terraform apply 
``` 

- Check the output is the following
```shell
data.aws_iam_policy_document.example_destination: Reading...
data.aws_iam_policy_document.example_source: Reading...
data.aws_iam_policy_document.example_destination: Read complete after 0s [id=1215959346]
data.aws_iam_policy_document.example_source: Read complete after 0s [id=3009975100]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_appflow_flow.example will be created
  + resource "aws_appflow_flow" "example" {
      + arn      = (known after apply)
      + id       = (known after apply)
      + kms_arn  = (known after apply)
      + name     = "example"
      + tags_all = (known after apply)

      + destination_flow_config {
          + connector_type = "S3"

          + destination_connector_properties {
              + s3 {
                  + bucket_name   = "daniela-destination"
                  + bucket_prefix = (known after apply)

                  + s3_output_format_config {
                      + file_type = "JSON"

                      + aggregation_config {
                          + aggregation_type = "None"
                        }
                    }
                }
            }
        }

      + source_flow_config {
          + connector_type = "S3"

          + source_connector_properties {
              + s3 {
                  + bucket_name   = "daniela-source"
                  + bucket_prefix = (known after apply)
                }
            }
        }

      + task {
          + destination_field = "exampleField"
          + source_fields     = [
              + "exampleField",
            ]
          + task_type         = "Map"

          + connector_operator {
              + s3 = "NO_OP"
            }
        }

      + trigger_config {
          + trigger_type = "OnDemand"
        }
    }

  # aws_s3_bucket.example_destination will be created
  + resource "aws_s3_bucket" "example_destination" {
      + acceleration_status         = (known after apply)
      + acl                         = (known after apply)
      + arn                         = (known after apply)
      + bucket                      = "daniela-destination"
      + bucket_domain_name          = (known after apply)
      + bucket_prefix               = (known after apply)
      + bucket_regional_domain_name = (known after apply)
      + force_destroy               = false
      + hosted_zone_id              = (known after apply)
      + id                          = (known after apply)
      + object_lock_enabled         = (known after apply)
      + policy                      = (known after apply)
      + region                      = (known after apply)
      + request_payer               = (known after apply)
      + tags_all                    = (known after apply)
      + website_domain              = (known after apply)
      + website_endpoint            = (known after apply)
    }

  # aws_s3_bucket.example_source will be created
  + resource "aws_s3_bucket" "example_source" {
      + acceleration_status         = (known after apply)
      + acl                         = (known after apply)
      + arn                         = (known after apply)
      + bucket                      = "daniela-source"
      + bucket_domain_name          = (known after apply)
      + bucket_prefix               = (known after apply)
      + bucket_regional_domain_name = (known after apply)
      + force_destroy               = false
      + hosted_zone_id              = (known after apply)
      + id                          = (known after apply)
      + object_lock_enabled         = (known after apply)
      + policy                      = (known after apply)
      + region                      = (known after apply)
      + request_payer               = (known after apply)
      + tags_all                    = (known after apply)
      + website_domain              = (known after apply)
      + website_endpoint            = (known after apply)
    }

  # aws_s3_bucket_policy.example_destination will be created
  + resource "aws_s3_bucket_policy" "example_destination" {
      + bucket = (known after apply)
      + id     = (known after apply)
      + policy = jsonencode(
            {
              + Statement = [
                  + {
                      + Action    = [
                          + "s3:PutObjectAcl",
                          + "s3:PutObject",
                          + "s3:ListBucket",
                          + "s3:GetObject",
                          + "s3:GetBucketAcl",
                        ]
                      + Effect    = "Allow"
                      + Principal = {
                          + Service = "appflow.amazonaws.com"
                        }
                      + Resource  = [
                          + "arn:aws:s3:::daniela-destination/*",
                          + "arn:aws:s3:::daniela-destination",
                        ]
                      + Sid       = "AllowAppFlowSourceActions"
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
    }

  # aws_s3_bucket_policy.example_source will be created
  + resource "aws_s3_bucket_policy" "example_source" {
      + bucket = (known after apply)
      + id     = (known after apply)
      + policy = jsonencode(
            {
              + Statement = [
                  + {
                      + Action    = [
                          + "s3:PutObjectAcl",
                          + "s3:PutObject",
                          + "s3:ListBucket",
                          + "s3:GetObject",
                          + "s3:GetBucketAcl",
                        ]
                      + Effect    = "Allow"
                      + Principal = {
                          + Service = "appflow.amazonaws.com"
                        }
                      + Resource  = [
                          + "arn:aws:s3:::daniela-source/*",
                          + "arn:aws:s3:::daniela-source",
                        ]
                      + Sid       = "AllowAppFlowSourceActions"
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
    }

  # aws_s3_object.example will be created
  + resource "aws_s3_object" "example" {
      + acl                    = (known after apply)
      + bucket                 = (known after apply)
      + bucket_key_enabled     = (known after apply)
      + checksum_crc32         = (known after apply)
      + checksum_crc32c        = (known after apply)
      + checksum_sha1          = (known after apply)
      + checksum_sha256        = (known after apply)
      + content_type           = (known after apply)
      + etag                   = (known after apply)
      + force_destroy          = false
      + id                     = (known after apply)
      + key                    = "daniela_source.csv"
      + kms_key_id             = (known after apply)
      + server_side_encryption = (known after apply)
      + source                 = "daniela_source.csv"
      + storage_class          = (known after apply)
      + tags_all               = (known after apply)
      + version_id             = (known after apply)
    }

Plan: 6 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_s3_bucket.example_destination: Creating...
aws_s3_bucket.example_source: Creating...
aws_s3_bucket.example_source: Creation complete after 2s [id=daniela-source]
aws_s3_bucket_policy.example_source: Creating...
aws_s3_object.example: Creating...
aws_s3_bucket.example_destination: Creation complete after 2s [id=daniela-destination]
aws_s3_bucket_policy.example_destination: Creating...
aws_appflow_flow.example: Creating...
aws_s3_object.example: Creation complete after 0s [id=daniela_source.csv]
aws_s3_bucket_policy.example_source: Creation complete after 0s [id=daniela-source]
aws_s3_bucket_policy.example_destination: Creation complete after 0s [id=daniela-destination]
aws_appflow_flow.example: Creation complete after 1s [id=arn:aws:appflow:eu-west-1:323533494701:flow/example]

Apply complete! Resources: 6 added, 0 changed, 0 destroyed.
```

- Destroy the resources
```shell
terraform destroy
```

- Confirm the output will destroy 6 resources
```shell
Plan: 0 to add, 0 to change, 6 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

aws_s3_bucket_policy.example_destination: Destroying... [id=daniela-destination]
aws_s3_bucket_policy.example_source: Destroying... [id=daniela-source]
aws_s3_object.example: Destroying... [id=daniela_source.csv]
aws_appflow_flow.example: Destroying... [id=arn:aws:appflow:eu-west-1:323533494701:flow/example]
aws_s3_object.example: Destruction complete after 0s
aws_s3_bucket_policy.example_destination: Destruction complete after 0s
aws_s3_bucket_policy.example_source: Destruction complete after 0s
aws_appflow_flow.example: Destruction complete after 1s
aws_s3_bucket.example_destination: Destroying... [id=daniela-destination]
aws_s3_bucket.example_source: Destroying... [id=daniela-source]
aws_s3_bucket.example_source: Destruction complete after 0s
aws_s3_bucket.example_destination: Still destroying... [id=daniela-destination, 10s elapsed]
aws_s3_bucket.example_destination: Destruction complete after 16s

Destroy complete! Resources: 6 destroyed.
```
