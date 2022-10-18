# Review-Trackers-Project

### Description
Trunk-Based Development in a MonoRepo thus so many testing commits since this is a rushed one-day project. Essentially, we have four workflows ~
- Docker-workflow: Builds and pushes docker file to a public dockerhub account
- Terraform-kube-workflow: Initializes terraform creating AKS cluster then creates Kubernetes deployment and service. 
- Continuous-Deployment: Continuously applies terraform code 
- Terraform-Destroy: Only on manual trigger kills the environment 

###### Note: Everything here has been done with this being a interview project in mind. And, of course, in practice there would better commits more granular with better descriptions and well-tested. 



## Table of Contents

- [Python](#Python)
- [Terraform](#Terraform)
- [Kubernetes](#Kubernetes)
- [Workflows](#Workflows)
- [Requirements Met](#Requirements)

--------------

## Python

The python directory contains a python file that launches a HHTP server with two endpoints /status and /ip which both append the default html created by the BaseHTTPRequestHandler module with their respective json values. 

### improvements
- 
- Dockerfile could have used a better python base image for more buildable platform. The initial assumption: since there aren't modules called that are precompiled in other builds, alpine would be the fastest and the most light-weight solution. Resolution: There are actually two benefits two using slim images: they have better precompiled modules and they are buildable in many different platforms.  

## Terraform
## Kubernetes
## Workflows
## Requirements
## Improvements