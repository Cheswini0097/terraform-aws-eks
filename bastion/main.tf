module "basition" {
    source = "terraform-aws-modules/ec2-instance/aws"
    
    vpc_security_group_ids = data.aws_ssm_parameter.bastion_sg_id
    subnet_id = local.public_subnet_id.id
    ami = data.aws_ami.expense.id
    instance_type = "t3.micro"
    name = local.resource_name
    user_data = file("bastion.sh")
    tags = merge(
        var.common_tags,
        var.bastion_sg_tags,
        {
            Name = local.resource_name
        }
    )
    
    



}