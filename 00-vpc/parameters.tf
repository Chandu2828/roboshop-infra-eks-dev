# This Terraform code saves your network layout variables directly into AWS Systems Manager (SSM) Parameter Store. 
# This setup creates a central source of configuration data, allowing other independent Terraform projects 
# (like an EKS cluster or application microservices)  to easily discover and read these network IDs without hardcoding them.

resource "aws_ssm_parameter" "vpc_id" {
    name        = "/${var.project}/${var.environment}/vpc_id"
    type        = "String"
    value       = module.vpc.vpc_id 
    overwrite   = true 
}

resource "aws_ssm_parameter" "public_subnet_ids" {
    name        = "/${var.project}/${var.environment}/public_subnet_ids"
    type        = "String"
    value       = join(",",module.vpc.public_subnet_ids)
    overwrite   = true 
}

resource "aws_ssm_parameter" "private_subnet_ids" {
    name        = "/${var.project}/${var.environment}/private_subnet_ids"
    type        = "String"
    value       = join(",",module.vpc.private_subnet_ids)
    overwrite   = true 
}

resource "aws_ssm_parameter" "database_subnet_ids" {
    name        = "/${var.project}/${var.environment}/database_subnet_ids"
    type        = "String"
    value       = join(",",module.vpc.database_subnet_ids)
    overwrite   = true 
}