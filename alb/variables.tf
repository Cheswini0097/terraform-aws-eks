variable "project_name" {
    default = "expense"
  
}
variable "envinorment" {
    default = "dev"
  
}
variable "common_tags" {
    default = {
        project_name = "expense"
        environment = "dev"
        terraform = "true"
    }
  
}
variable "ingress_alb_tags" {
    default = {
        Component = "web-alb"
    }
  
}
variable "zone_name" {
    default = "cheswini.shop"
  
}