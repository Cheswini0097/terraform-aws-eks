# Teraform Interview Questions

What is state in Teraform ?
```
Terraform uses the state file to comapare acutual infrastructure created and declared infrastructure throuugh the tf.files

it genrally stores the state file in to terraform.tfstate.

State file is = actuall infrastructure created by terraform
Desired infrastructure = declared through the .tffiles
```
What is Remote-State in Terraform?
```
Saveing File locally is not recomended in the terraform because in Collabrative enviroment.
Multiple persons working in the same infra, so there is high posibalites of duplicates and error if we save the state locally

Teraform recomends storeing the state remotely and accessible for the entrie team and it should be locked this help to make the errors and Duplications in the infrastructure


backend "s3" {
    buccket = "timing-bucket"
    key = "provisioners"
    region = "us-east-1"
    dynamodb_table = "timing_lock"

}
```
What is diffrence between data block and resource Block in the terraform ?
```
Data block and resource blocks are the essential components in the Terraform but it used for the diffrent purposes


Data block : data is used to get information of the resources which are already existed with in the resources or exteranl

resources : these component used to create or destroy and manange the resources the resources, in the terraform ,

fuction : thes defines the required resources and intract with the provider to to create or destroy  the resource.
```
Explain  variables in the terraform?
```
Variables are used to parameterize the infrastructure we can provide the dynamic value to the configuration through the variables

we can supply the values to the to terraform as variables from the variables.tf with changeing the acutual code.

we have types of variables

1. "string"
2.  "bool"
3. "number"
4 . "Map"
5 ."list"
```

What is Tfvars in the terraform ?
```
Ans: tf.vars is the file in the terraform in which we have keyvalue pairs it is used to supply the key values from the the terraform variables

If we declared default values in the variables we can override the variable values and supply values useing .tfvars 

we can use diffrent .tfvars files like dev.tfvars, prod.tfvars

we supply the tf vars useing commnad like 

terraform apply -var-file=dev.tfvars
```
What is count and count.idex in the terraform?
```
In terraform count is parameter used to to create the multiple instances of the resource based on the specified count value.

example:

main.tf

resource "aws_subnet" "pubiic" {
  count = length(var.public_subnet_cidrs)
  vpc_id = aws_vpc_main.vpc_id
  cidr_block = var.public_subnet_cidrs[count.index]
  availability_zone = var.availability_zone[count.index]
  tags = merge(
    var.tags,
    var_public_subnet_tags,
    {"Name"= var.public_subnet_names[count.index]}
  )
}

variables .tf
variable "availability_zone" {
    default = ["ap-south-1a", "ap-south-1b"]

  
}
variable "public_subnet_cidrs" {
    default = ["10.20.15.1/24", "10.12.15.16/24"]
  
}
```
what is output in the terraform?
```
Ans: While createing the resources in the terraform it gives us the attributes of the resources which we have created, these outputs are use full to create other dependencey resources 
we store the atributes useing the outputs.tf
example : vpc_id
          public_subnet_ids.
```
What are data source in the tearra form?
```
We can querry the data from cloud useing the data sources, we can reterive the existing resources useing the datasources and use them in create other resources.

example: 
data "aws_ssm_parameter" "vpc_id"{
    name = "${var.project_name}-${var.enviroment}-vpc_id"
}
```
What are Locals in the terraform?
```
Ans: Locals are like variables in some aspects,it has some extra feautures we assing some expression and function for the local and use where ever we want.

variable can override useing command line but local cannot

Locals {
    resource_name = "${var.enviroment}-${var.project_name}"#comibining the diffrent tags
    public_subnet_ids = split(data.public_subnet_ids.value)[0]
    
}
```
What are the functions in terraform and name few functions you used?
```
functions are to do unit of work, it takes input and gives the output to us ,
we have many types of functions in the terraform,
like:
     split= to split the group value and to give the seperate value,
     file = function used to read the file and take the declared action in the file
     Slice= these fuction used to get the partfrom list
     join
     ELement to findout particular index ELement
```
How do you Manage the credintials in the terraform
```
Best practices are setting the enviroment variable before we plan and applt the infra in the terraform.
once its applied we can unset the 
We can store the credintials in the Jenkins Credintials.
If we are following the Jenkins CICD. in Jenkins

use the "with Credintials" block to inject the credintials for the terraform pipeline

if we are running the terraform useing Ec2 we can assing the Iam roles.
```
Explain the Concepts of the Work space in the Terraform 
```
terraform Work space is used to create the difrrent infrastructure  useing the same come.
 wecan create multiple work space useing the terraform work space Command

 Terraform will give the special variable called the terraform.workspace useing this we can conntroll the variable passedon it

 commands:
          terraform workspace new dev "creates new workspace "dev"
          terraform workspace select dev  =switchs to the work space dev
          terraform workspace list = list the workspaces
          terraform workspace show : shows the current work space

example how to use:

resource "aws_ec2_instance" "frontend"
ami = "ami_123"
instance_type = "t3.micro"
tags = {
    Name = "app-${terraform.workspace}"
}
```
How does terraform manange updates to existing resource?
```
Terraform always tries to match the defined or declared infra with actual infrastructure,

Terraform has state file to track what is was created earlier when we plan or apply the it will refresh and check wheather applied infrastructre  is same or not if any thing chages done from outside it notifies once we aplly the code it make chages and matches the declared infra with actual infrastructure.
```
Give terraform configuration to create the single Ec2 instance 

provider.tf
```
terraform {
    required_provider {
        aws = {
            source ="hashicorp/aws"
            version = "5.66.0"

        }
    }
    backend "s3" {
        bucket = "cheswini-bucket"
        key = "cheswini_key"
        region = "us-east-1"
        dynamodb_table = "cheswini_locking"



    }
}
provider "aws"
#configuration options
region = "us-east-1"
}
```
variables.tf
```
Variables "
```

How to store the sensitive data in the terraform
```
We can use vault or aws_secret manger or parameter secure string if user has running the secret Manager at run time it can fetch the at run time securely
```
If  i loose the state file in the terraform how i can recover ?
```
if we lose the state file it is the serious issue.
State file is used to track the infra created.
we should follow some best practices to keep the state file secure and in position to recover.

practices:
#we must use a remote state and locking mechanism 
#We have to enable versioning
#we must use the data replication  it means if states file changes it will take another copy the state file and save in the other bucket in other region.
#implement proper iam roles to acess the state file
#monitor and alerting the mechanism


Still if we lose the State file we need to restrore it manually.
```
What are commands of terraform apart from init,apply,plan?
```
terraform fmt : command to beautify the structure of the terraform file

terraform validate: command is used to validate the syntax

terraform taint : taints the resource it means it recreates the resource  if resources are corrupted

terraform target : these command is used to create or destroy the particular resource.

terraform import : these command is used to import the existing resource to the terraform.

terraform workspace : these commands used ton manage the terraform work spaces
```
What is null resource in the terraform?
```
Null resource wonot create the any resource.

we use null resource for provisioners like remote exec, local exec, file provisioners trigress etc..
```
What are modules in the terraform ?
```
module are like DRY donot repeat your self.

We can create a code once and reuse the code for the multiple projects 

there are multiple advantages in modules

Centralised code
Enfore the best practices
Easy maintainence
Control over the resource
Consistancy accross the resources.
```
What is the diffrence between Ansible and Terraform?
```
Ansible in the Configuration Management tool.



   
        
          


