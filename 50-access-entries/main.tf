# To grant your bastion host administrative access to Amazon EKS cluster 

resource "aws_eks_access_entry" "bastion" {
    cluster_name    = local.eks_cluster_name # Tells EKS which cluster is granting access 
    principal_arn   = local.bastion_iam_role_arn # Maps the specific IAM Role ARN created for your bastion host(from your previous code block) to the cluster
    type            = "STANDARD"
}

resource "aws_eks_access_policy_association" "bastion" {
    cluster_name = local.eks_cluster_name 
    policy_arn   = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
    # Attaches the AWS-managed cluster adimistrator policy. This gives anyone logged into the bastion full cluster-admin
    # control over all kubernetes resources, namespaces and nodes. 
    principal_arn = local.bastion_iam_role_arn 
    # Sets the permission boundary globally across the entire cluster
    access_scope {
        type = "cluster"
    }
}
