#Change bucket name to your own bucket. I recommend not using same bucket as your
#website to prevent accidental exposure of Terraform state. Also change profile to
#the AWS credentials profile you want to use.
terraform {
 backend "s3" {
   bucket         = "hierux-terraform"
   key            = "terraform.tfstate"
   region         = "us-west-1"
   encrypt        = true
   dynamodb_table = "terraform-lock"
   profile        = "terraform"
 }
}