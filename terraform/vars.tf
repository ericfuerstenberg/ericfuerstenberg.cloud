variable "aliases" {
 type        = "list"
 default     = ["www.hierux.cloud", "hierux.cloud"]
 description = "List of hostname aliases"
}
variable "aws_region" {
 default = "us-east-1"
}
variable "bucket_name" {
 default = "hierux.cloud"
}
variable "codeship_username" {
 default = "codeship"
}
variable "cert_domain_name" {
 default = "hierux.cloud"
}
variable "aws_zone_id" {
 default     = "Z06950211Y62TGQGKYGUK"
 description = "AWS Route 53 Zone ID for DNS"
}
variable "hostname" {
 default     = "hierux.cloud"
 description = "Full hostname for Route 53 entry"
}
variable "deployment_user_arn" {
  description = "ARN for user who is able to put objects into S3 bucket"
  type        = string
  default     = "arn:aws:iam::555636082612:user/codeship"
}
