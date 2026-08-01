resource "aws_iam_role" "bastion" {
    name = "${local.common_name}-bastion"

    # Terraform's "jsonencode" function converts a 
    # Terraform expression result to vaild JSON syntax. 
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action  = "sts:AssumeRole"
                Effect  = "Allow"
                Sid     = ""
                Principal = {
                    Service = "ec2.amazonaws.com" # This is a trust policy which explicitly grants permission to the Amazon Ec2 service to assume this rol
                }
            },
        ]
    })

    tags = merge(
        local.common_tags,
        {
            Name = "${local.common_name}-bastion"
        }
    )
}

resource "aws_iam_role_policy_attachment" "bastion" {
    role        = aws_iam_role.bastion.name 
    policy_arn  = "arn:aws:iam:aws:policy/AdministratorAccess"
}

resource "aws_iam_instance_profile" "bastion" {
    name = "${local.common_name}-bastion"
    role = aws_iam_role.bastion.name 
}

# EC2 instances cannot directly assume an IAM role on their own; they require a container called an Instance Profile.
# This block creates that container and links it to your IAM role via role = aws_iam_role.bastion.name. 
# When you write your aws_instance resource later, you will pass this instance profile name to it.