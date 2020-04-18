+++
title = "Hosting a high performance static site with S3, Route53, & SSL via CloudFront"
date = 2020-04-18T14:39:34-07:00
tags = [
    "learning",
    "aws",
    "cloud",
    "s3",
    "route53",
    "cloudfront",
]
+++

## Update: Hugo

I recently reconfigured my static website (still hosted at [cloud.hierux.com](http://cloud.hierux.com)) into a more feature rich site using [Hugo](https://gohugo.io/) - you're looking at it right now! This allows me to make use of style templates and other feature enhancements while keeping things simple with markdown.

You can find the Hugo-ified version of my website in my [Github repo.](https://github.com/ericfuerstenberg/hierux.cloud)

I've hosted static sites using a number of different strategies in the past. For example, I used to have a blog running in a dockerized nginx configuration on an ec2 instance. Other times I've simply used httpd and a static index.html file living on an ec2 instance. However, all of these cases required some management of the underlying infrastructure via ssh and this meant that I'd need to configure security groups, keep track of private keys, and maintain the underlying instances via regular updates. Nothing nightmare inducing, but they still required regular ssh checkups and tinkering to keep things running as expected.

## High availability, high performance, low latency

Cue **static hosting with AWS S3** - a serverless solution to hosting static websites. Simply create a couple S3 buckets, enable static hosting, and upload your content. Then configure DNS for your domain names, add SSL encryption via Amazon Certificate Manger & CloudFront, and you've got a simple site up and running. 

By using a combination of S3, CloudFront, and Route53 you can set up a highly available static website with high performance and low latency. 

## Here was my process..
**S3**
1. create two S3 buckets (one for hierux.cloud and another for www.hierux.cloud that will handle redirects)
2. upload your public content (in my case, everything in my `public/` directory under my hugo project)
    - `aws s3 cp public/ s3://hierux.cloud --recursive`
3. enable static website hosting on your main bucket & enter your index and error documents
    - Make note of the bucket endpoint (e.g., `http://your-bucket-name.s3-website.your-region-here.amazonaws.com`) - you'll need this later when configuring your CloudFront origin.
4. write a simple S3 bucket policy in JSON that allows full access to S3:GetObjects in your primary bucket (hierux.com)
5. you should now simply be able to access your hugo website by navigating to the bucket endpoint - I ran into some issues with the default `baseURL` set in my `config.toml` file. I changed it to reflect my S3 endpoint and repopulated the `public/` directories by relaunching my site locally before syncing my changes up to s3 again using `aws s3 sync public/ s3://hierux.cloud`. Once this was complete the site was loading as expected via S3. 

**route 53 for dns**
   - CNAME pointing www.hierux.cloud to hierux.cloud
   - Alias record pointing hierux.cloud to my cloudfront distribution endpoint (allows us to handle redirects)

**SSL & amazon certificate manager**
   - set up a basic SSL certificate covering www.hierux.com and hierux.com endpoints
   - since this is all native to AWS, Route53 takes care of the DNS validation for you during the ssl cert generation process (otherwise you would need to validate via email)

**configure cloudfront distribution**
    - speed up load times (serve static content closer to our end users) and provide SSL encryption for added security using CloudFront