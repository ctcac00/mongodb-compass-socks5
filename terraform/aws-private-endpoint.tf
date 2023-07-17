resource "aws_vpc" "vpc" {
  cidr_block = local.aws_route_cidr_block
  # Required to resolve hostname to internal addresses
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"

  tags = local.tags
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = local.aws_subnet1_cidr_block

  tags = local.tags
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_internet_gateway" "main_gw" {
  vpc_id = aws_vpc.vpc.id

  tags = local.tags
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_route_table" "main_route" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_gw.id
  }

  tags = local.tags
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_route_table_association" "main-subnet" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.main_route.id
}

resource "aws_security_group" "main" {
  vpc_id = aws_vpc.vpc.id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port   = 1024
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [local.aws_subnet1_cidr_block]
  }
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    // Put your office or home address in it!
    cidr_blocks = [var.provisioning_address_cdr]
  }

  ingress {
    from_port = 1080
    to_port   = 1080
    protocol  = "tcp"
    // Put your office or home address in it!
    cidr_blocks = [var.provisioning_address_cdr]
  }

  ingress {
    from_port = 1024
    to_port   = 65535
    protocol  = "tcp"
    // Enable inbound ports to Endpoint service
    cidr_blocks = [local.aws_route_cidr_block]
  }

  tags = local.tags
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_vpc_endpoint" "ptfe_service" {
  vpc_id             = aws_security_group.main.vpc_id
  service_name       = mongodbatlas_privatelink_endpoint.test.endpoint_service_name
  vpc_endpoint_type  = "Interface"
  security_group_ids = [aws_security_group.main.id]
  subnet_ids         = [aws_subnet.subnet1.id]
}
