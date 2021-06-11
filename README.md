# About
The purpose of this project is to familiarize myself with Terraform and AWS by creating multiple novice infrastrucutre scenarios.

## Branches
* main
    * base terraform configuration
* web-server
    * Configurable web-server
* cluster
    * Cluster of auto-scaling web-servers with load-balancer

## Pre-requisites
#### Terraform
* [Download/install Terraform](https://www.terraform.io/downloads.html)

#### Cloud provider
For this project I used AWS as my cloud provider
* [AWS Subscription](https://aws.amazon.com/)
* [AWS CLI](https://aws.amazon.com/cli/)
* [AWS CLI Configuration](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)

## Initial project config
#### Clone project
* get a local copy of the project
    * `https://github.com/MJRAMZ/terraform-aws-infra.git`

#### Initialize Terraform
* navigate to the **"base"** directory of your local repo copy
    * `cd base`
* initialze the configuration file
    * `terraform init`
* check the formatting of the configuration file
    * `terraform fmt`
* Check the configuration file for errors
    * `terraform validate`

## Deploy Infrastructure
* create and output an execution plan to a file
    * ```terraform plan - out base-`date +'%s'`.plan```
* apply the execution plan
    * `terraform apply <plan_file_name>`

## Teardown Infrastructure
* `terraform destroy`




# References
Used the following resources as helpful guides, adjusting code templates as needed to get things working correctly.

* [AWS Docs](https://docs.aws.amazon.com/)
* [Terraform Docs](https://www.terraform.io/docs/index.html)
* [Terraform AWS Provider Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
* [Terraform Up and Running, 2nd Ed.](https://www.oreilly.com/library/view/terraform-up/9781492046899/)
* [The Terraform Book](https://terraformbook.com/)