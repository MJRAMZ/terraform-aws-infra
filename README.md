# About
The purpose of this branch is to deploy a simple single server web architecture in AWS that can respond to HTTP requests.

![Single Server Architecture](/diagrams/AWS_Single-Server.png)


## Pre-requisites
### Terraform
* [Download/install Terraform](https://www.terraform.io/downloads.html)

### Cloud provider
For this project I used AWS as my cloud provider
* [AWS Subscription](https://aws.amazon.com/)
* [AWS CLI](https://aws.amazon.com/cli/)
* [AWS CLI Configuration](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)

## Initial project config
### Clone project
* get a local copy of the project
    * `https://github.com/MJRAMZ/terraform-aws-infra.git`

### Initialize Terraform
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
    * ```terraform plan - out webserver-`date +'%s'`.plan```
* apply the execution plan
    * `terraform apply <plan_file_name>`

You should see some output similar to the following:

![Terraform Output](/diagrams/apply_outputs.png)

Give your instance a couple of minutes to boot up then check the server with a web-browser or `curl` command and you should see the following output:
```
$ curl http://<Your_EC2_Instance_Public_IP>:8080
Hello, World
```

## Teardown Infrastructure
* `terraform destroy`



# References
Used the following resources as helpful guides, adjusting code templates as needed to get things working correctly.

* [AWS Docs](https://docs.aws.amazon.com/)
* [Terraform Docs](https://www.terraform.io/docs/index.html)
* [Terraform AWS Provider Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
* [Terraform Up and Running, 2nd Ed.](https://www.oreilly.com/library/view/terraform-up/9781492046899/)
* [The Terraform Book](https://terraformbook.com/)