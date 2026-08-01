terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws" # tells terraform to download the official AWS registry plugin managed by HashiCorp.
            version = "6.48.0" # Locks your project to this specific version of the AWS provider to prevent changes from future updates.
        }
    }

    # remote state storage location
    # Configures terraform to store its architecture blueprint(.tftstate file) in Amazon S3 instead of your local computer. This allows team collaboration
    backend "s3" {
      bucket        = "remote-state-90s-practice-dev" # Name of the S3 bucket where the state file is stored. 
      key           = "roboshop-eks-vpc.tfstate" # The exact folder path and file name inside the bucket. 
      region        = "us-east-1" # Physical AWS data center location where your S3 bucket lives 
      encrypt       = true # Automatically encrypts your state file at rest inside the S3 bucket to protect sensitive infrastructure data like passwords or keys. 
      use_lockfile  = true # Utilizes native S3 state locking to prevent multiple team members from running Terraform at the exact same time, which prevents state corruption.
    }
}

# Configure the AWS Provider
# Initializes the connection between terraform and the Amazon Web services API.  
provider "aws" {
    region = "us-east-1"
    # Sets the default geographic location for your infrastructure to US East (N. Virginia). 
    # Any AWS resources you define below this block (like servers, databases, or networks) will be built in this specific region unless you explicitly override it.
}

