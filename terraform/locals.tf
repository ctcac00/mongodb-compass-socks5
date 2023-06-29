locals {
  # Generic project prefix, to rename most components
  prefix = "carlos-test1"
  # Atlas region,https://docs.atlas.mongodb.com/reference/amazon-aws/#std-label-amazon-aws
  region = "EU_WEST_1"
  # IAM policy name
  aws_policy_name = "${local.prefix}-kms-policy"
  # IAM role name
  aws_role_name = "${local.prefix}-kms-role"
  # Atlas Pulic providor
  provider_name = "AWS"
  # AWS Region
  aws_region = "eu-west-1"
  # AWS Rooute block
  aws_route_cidr_block = "10.11.6.0/23"
  # AWS Subnet block
  aws_subnet1_cidr_block = "10.11.6.0/24"
  tags = {
    Name      = "${local.prefix}-tf-provisioned"
    owner     = var.user_email
    expire-on = timeadd(timestamp(), "760h")
    purpose   = "training"
  }

  # Instance type to use for testing
  aws_ec2_instance = "t3.small"
  # Instance name
  aws_ec2_name = "${local.prefix}-vm"

  user_data = <<-EOT
  #!/bin/bash

  apt-get -y update && apt-get -y install microsocks
  
  EOT

  # Atlas cluster name
  cluster_name = "${local.prefix}-cluster"
  # Atlas size name 
  atlas_size_name = "M10"
  # Atlas user name
  admin_username = "demouser1"
  # Atlas region,https://docs.atlas.mongodb.com/reference/amazon-aws/#std-label-amazon-aws
  region_name = "EU_WEST_1"
}

terraform {
  required_version = ">= 0.13.05"
}
