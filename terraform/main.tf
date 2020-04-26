// Create S3 bucket and CloudFront distribution using Terraform module
// designed for S3/CloudFront configuration of a Hugo site.
// See: https://registry.terraform.io/modules/fillup/hugo-s3-cloudfront/aws/4.0.0

module "hugosite" {
 source         = "fillup/hugo-s3-cloudfront/aws"
 version        = "4.0.0"
 aliases        = "${var.aliases}"
 aws_region     = "${var.aws_region}"
 bucket_name    = "${var.bucket_name}"
 cert_domain    = "${var.cert_domain_name}"
 deployment_user_arn = "${var.deployment_user_arn}"
 cf_default_ttl = "0"
 cf_max_ttl     = "0"
}

// Create IAM user with limited permissions for Codeship to deploy site to S3

resource "aws_iam_user" "codeship" {
 name = "${var.codeship_username}"
}
resource "aws_iam_access_key" "codeship" {
 user = "${aws_iam_user.codeship.name}"
}
data "template_file" "policy" {
 template = "${file("${path.module}/bucket-policy.json")}"
 vars = {
   bucket_name = "${var.bucket_name}"
   deployment_user_arn = "${var.deployment_user_arn}"
 }
}
resource "aws_iam_user_policy" "codeship" {
 user   = "${aws_iam_user.codeship.name}"
 policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
            "s3:PutObject",
            "s3:PutObjectAcl"
        ],
        "Effect": "Allow",
        "Resource": "arn:aws:s3:::${var.bucket_name}/public/*"
      }
    ]
  }
  EOF
}  

#Add record to Route 53
resource "aws_route53_record" "www" {
 zone_id = "${var.aws_zone_id}"
 name    = "${var.hostname}"
 type    = "A"
 alias {
   name = "${module.hugosite.cloudfront_hostname}"
   zone_id = "Z2FDTNDATAQYW2"
   evaluate_target_health = false
 }
}

# #Import existing S3 bucket
# resource "aws_s3_bucket" "hierux-cloud" {
#   # ...instance configuration...
# }