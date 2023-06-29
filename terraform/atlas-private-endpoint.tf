resource "mongodbatlas_privatelink_endpoint" "test" {
  project_id    = var.project_id
  provider_name = local.provider_name
  region        = local.region
}

# Private Link Endpoint service
resource "mongodbatlas_privatelink_endpoint_service" "test" {
  project_id          = mongodbatlas_privatelink_endpoint.test.project_id
  private_link_id     = mongodbatlas_privatelink_endpoint.test.private_link_id
  endpoint_service_id = aws_vpc_endpoint.ptfe_service.id
  provider_name       = local.provider_name
}
