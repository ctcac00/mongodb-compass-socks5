output "ec2_public_dns" {
  description = "Virtual Machine Address"
  value       = aws_instance.instance.public_dns
}

output "mongodb_atlas_connection_string" {
  value = join("", [
    replace("${mongodbatlas_advanced_cluster.cluster.connection_strings[0].private_endpoint[0].srv_connection_string}", "mongodb+srv://", "mongodb+srv://${local.admin_username}:${var.admin_password}@"),
  "/bank"])
}
