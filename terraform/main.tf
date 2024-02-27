terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      Version = "~>3.27"
    }
  }

  required_version = ">=0.14.9"
   backend "s3" {
       bucket = "tfstate-gitlab"
       key    = "terraform.tfstate"
       region = "us-west-2"
}

provider "aws" {
  version = "~>3.0"
  region  = "us-west-2"
}

resource "aws_s3_bucket" "s3Bucket" {
     bucket = "tfstate-gitlab"
     acl       = "public-read"

     policy  = <<EOF
{
     "id" : "MakePublic",
   "version" : "2012-10-17",
   "statement" : [
      {
         "action" : [
             "s3:GetObject"
          ],
         "effect" : "Allow",
         "resource" : "arn:aws:s3:::tfstate-gitlab/*",
         "principal" : "*"
      }
    ]
  }
EOF

   website {
       index_document = "index.html"
   }
}
