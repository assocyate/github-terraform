terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  backend "s3" {
    region = "us-west-2"
    key    = "terraform.tfstate"
    bucket = "tfstate-gitlab"
    #dynamodb_table = "Terraform-table-lock"
  }
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "test_instance" {
  ami           = "ami-830c94e3"
  instance_type = "t2.nano"
  tags = {
    Name = "test_instance"
  }
}
