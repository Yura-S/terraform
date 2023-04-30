terraform {
  backend "s3" {
    bucket = "my-tf-state777"
    key    = "states"
    region = "us-east-1"
  }
}
