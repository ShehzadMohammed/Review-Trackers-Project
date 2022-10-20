# Review-Trackers-Project

#### This project was LOTS of FUN! Thank you guys so much! Any criticisms and feedback is really appreciated. 
###### Note: Everything here has been done with this being a interview project in mind even this readme file. And, of course, in practice there would better commits more granular/meticulous with better descriptions and well-tested. 

### Description
Trunk-Based Development in a MonoRepo thus so many testing commits since this is a rushed one-day project. Essentially, we have four workflows ~
- Docker-workflow: Builds and pushes docker file to a public dockerhub account
- Terraform-kube-workflow: Initializes terraform creating AKS cluster then creates Kubernetes deployment and service. 
- Continuous-Deployment: Continuously applies terraform code and deploys Kubernetes. Generally should push to a staging environment such as spinnaker and run tests then deploy to prod. Another attribute that should be added is rollback on failed functionality or acceptance tests if we are directly deploying to production.  
- Terraform-Destroy: Only on manual trigger kills the environment 




## Table of Contents

- [Python](#Python)
- [Terraform](#Terraform)
- [Kubernetes](#Kubernetes)
- [Workflows](#Workflows)
- [Requirements Met](#Requirements)

--------------

## Python

The python directory contains a python file that launches a HHTP server with two endpoints /status and /ip which both append the default html created by the BaseHTTPRequestHandler module with their respective json values. /status should return after the base html "{"result": "success"}" and ip should return "" 

### improvements
- Testing the python server could have been an addition with more time this would be possible and a better library. The python server has been created using the HTTP server module to add creditability to python skills; however, in retrospect, more could been done using Flash or Django (or had I just noticed the file given in the start folder). 
- Dockerfile could have used a better python base image for more buildable platform. The initial assumption: since there aren't modules called that are precompiled in other builds, alpine would be the fastest and the most light-weight solution. Resolution: There are actually two benefits two using slim images: they have better precompiled modules and they are buildable in many different platforms.  

## Terraform

The module directory is used to provision AKS cluster for the python app and storage account for the tfstate file to migrate into and point the terraform backend script to. It creates a container in the storage account for the tfstate file. We can create a nested module here to create multiple containers as needed for future tfstate files for different azure landing zones. The one cycle of terraform provisioning and initializes environmental variables and storage account name based on date and time. The second script runs within the runner as bash as the second cycle of terraform provisioning. The first cycle will create the storage account and a SAS token which will be a fall back incase the primary access key does not work. The second cycle will migrate the backend to the newly created storage account therefore isolating the whole environment on the infrastructure itself. The AKS cluster is managed by azure due to the time crunch. 

### improvements
- AKS cluster should be self managed with better security in more sophisticated clusters. In this case, it is completely okay to use managed cluster since this is a very preliminary interview project. 
- The script could be improved on the GitHub Actions Runners since the pwsh shell in the runner could not properly compile the wholistic script so it was dividend into two separate scripts for initialization thus becoming "non-liftnshift" :)   ||| This could also be achieved using self-hosted runners as well. 
- Artifacts should be created and stored for every terraform cycle.

## Kubernetes 
The most simplest Kubernetes cluster implementation. 

### improvements
- At the inception of this project(Monday), the plan comprised of end-to-end observability, functionality and integration tests, and various security scans with a backend Postgres SQL DB with a fully functional API and managing the CI/CD on that  ~ however, it proved too much for the scope of this project. Originally helm charts where used with Prometheus and Grafana but soon removed realizing it was not possible for a 1-day project. Definitely, reimplementing all of these would make the project much better. 
- RBAC and general access control all through the environment would have been a considerable improvement, and implementing better networking principles with organizing a supernet and moving down --> to have better well documented project. (I love SDWAN controller!) 

## Workflows Improvements
- Less convoluted workflows with better documentation are essential ~ improve readability and future adoption from other engineers. 
- More testing and approval in workflows would also be a good edition.  

## Requirements
- All Requirements Met. 

## Stretch Goals Met: 
- CI 
- Kubernetes
- \ip however this does not work in Kubernetes due to kubeproxy. ~ No solution to this as of today however they are working on iptable implementation into kubernetes in the future. 

Hopefully this demonstrates that I am willing to go the mile for Review Trackers! This is not even close to my best work very rushed and lots of interruptions throughout the process. I love to be a review tracker :)
