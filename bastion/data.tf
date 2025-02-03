data "aws_ssm_parameter" "bastion_sg_id" {
    name = "/${var.project.name}/${var.environment}/bastion_sg_id"
    
  
}
data "aws_ssm_parameter" "public_subnet_ids" {
    name = "/${var.project_name}/${var.environment}/public_subnet_id"
  
}
data "aws_ami" "expense" {
    owners = ["973714476881"]
    most_recent = "true"

    filter {
        name = "name"
        values = [ "RHEL-9-DevOps-Practice" ]

      
    }
    filter {
       name   = "root-device-type"
       values = ["ebs"]
    }
    filter {
      name = ["virtualization-type"]
      values = ["hvm"]
    }
  
}
