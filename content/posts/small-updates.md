+++ 
draft = false
date = 2020-05-07T07:52:24-07:00
title = "Fail fast and iterate"
description = ""
slug = "" 
tags = [
    "hugo",
    "codeship",
    "git"
]
categories = []
externalLink = ""
series = []
+++

Today I made a small tweak to my CodeShip build/deployment pipeline. I had previously been committing the `public/` directory containing all of the generated assets for this website to my remote repo, which is definitely not best practice. This was also creating a problem where I'd need to 're-deploy' the site by running `hugo server` locally to generate all of the public assets before committing changes and pushing them to the remote master - if I failed to do this step the new changes would not be written to my S3 bucket by CodeShip.

Instead, I added the public/ directory to my .gitignore file and removed it from the remote repo (`git rm -r --cached public/`). I then had to reconfigure my CodeShip deployment steps to download and build my hugo site instead of relying on the existing public/ directory in the repo. 

I now have a much more efficient workflow. Simply make changes locally, test, then commit and push to my remote master. CodeShip will then deploy any updates to master to my S3 bucket and the changes will automatically reflect on the website. 

Here's to small, incremental improvements.. 

¯\\\_(ツ)\_/¯

