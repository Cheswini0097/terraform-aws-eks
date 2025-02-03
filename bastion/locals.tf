locals {
  public_subnet_id = split(",", data.aws_ssm_parameter.public_subnet_ids.value)[1]
  resource_name = "/${var.project_name}/${var.environment}-bastion"
}