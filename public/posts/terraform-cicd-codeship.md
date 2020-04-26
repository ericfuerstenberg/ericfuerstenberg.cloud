+++
title = "Automating with Terraform and CodeShip"
date = 2020-04-25T17:33:31-07:00
draft = false
tags = [
    "learning",
    "aws",
    "cloud",
    "s3",
    "route53",
    "cloudfront",
    "terraform",
    "ci/cd"
]
+++

## Rebuild it!

Today I completely tore down my existing infrastructure for this static website and rebuilt the entire thing in Terraform! It still uses AWS S3 static hosting, Route53, and CloudFront (for CDN and SSL), but I also integrated a CI/CD pipeline using CodeShip to increase the efficiency of pushing changes to production. 

1. use an external terraform module and configure settings
2. create an s3 bucket `hierux-terraform` to serve as the backend to store the .tfstate file safely
3. create a dynamo db to provide a state locking mechanism

4. ran into problems with the external module versioning - needed to upgrade to Terraform 0.12, which caused some other problems that I had to deal with
5. got the AWS infrastructure up and running after some time debugging the terraform code itself
6. configured S3 bucket at www.hierux.cloud to redirect requests to hierux.cloud - set an alias record pointing www.hierux.cloud to hierux.cloud in Route 53, which directs requests to the cloudfront endpoint with SSL enabled.
7. configure CI/CD pipeline using github and CodeShip. This allows me to push my local changes to master branch and automatically publish them to my production environment.

