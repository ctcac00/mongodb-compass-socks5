variable "atlas_public_key" {
  description = "MongoDB Atlas Public Key"
  type        = string
}
variable "atlas_private_key" {
  description = "MongoDB Atlas Private Key"
  type        = string
}
variable "user_email" {
  description = "Email address to add as tag"
  type        = string
  default     = "somebody@example.com"
}
variable "project_id" {
  description = "Atlas Existing Project ID Key"
  type        = string
}

variable "mongodb_project_name" {
  description = "Atlas Existing Project name"
  type        = string
}

variable "provisioning_address_cdr" {
  description = "Your provisioning address cidr block"
  type        = string
}

variable "admin_password" {
  description = "Password for AWS EC2 instance user"
  type        = string
}
variable "key_name" {
  description = "AWS EC2 Instance key name"
  type        = string
}

variable "private_key_path" {
  description = "AWS EC2 Instance access path to private key"
  type        = string
}

variable "aws_profile" {
  description = "AWS Profile to use"
  type        = string
  default     = "default"
}
