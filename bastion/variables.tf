variable "project_name" {
    default = "expense"
    
  
}
variable "environment" {
    default = "dev"
  
}
variable "bastion_sg_tags" {
    default = {
        Component = "bastion"
    }
  
}
variable "common_tags" {
    default = {
        environment = "dev"
        terraform = "true"
        project = "expense"
    }
  
}