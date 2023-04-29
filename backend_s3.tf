terraform {
  backend "s3" {
    bucket = "my-tf-state777"
    key    = "terraform.tfstate"
    region = "us-east-1"
    kms_key_id     = "alias/terraform-bucket-key"
    dynamodb_table = "terraform-up-and-running-locks"
    access_key = "AKIAX2264LPJALDXIW2C"
    secret_key = "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"
  }
 }