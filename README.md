# About
The purpose of this branch is to deploy a simple single server web architecture in AWS that can respond to HTTP requests.

![Single Server Architecture](/diagrams/AWS_Single-Server.png)

## Branches
* main
    * base terraform configuration
* web-server
    * Configurable web-server
* cluster
    * Cluster of web-servers with load-balancer and DB
* reusable-infra
    * Multi-environemnt infrastructure

# References
Used the following resources as helpful guides, adjusting code templates as needed to get things working correctly.

* [AWS Docs](https://docs.aws.amazon.com/)
* [Terraform Docs](https://www.terraform.io/docs/index.html)
* [Terraform AWS Provider Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
* [Terraform Up and Running, 2nd Ed.](https://www.oreilly.com/library/view/terraform-up/9781492046899/)
* [The Terraform Book](https://terraformbook.com/)