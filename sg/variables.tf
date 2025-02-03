variable "project_name" {
    default = "expense"
  
}
variable "environment" {
    default = "dev"
  
}
variable "common_tags" {
    default = {
        project_name = "expense"
        environment = "dev"
        terraform = "true"
    }
  
}
variable "mysql_sg_tags" {
    default = {
        Component = "mysql"
    }
}
variable "bastion_sg_tags" {
    default = {
        Component = "backend"
    }  
}
variable "eks_control_plane_sg_tags" {
    default = {
        Component = "eks_control_plane"
    }  
}

