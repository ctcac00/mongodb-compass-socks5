data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = local.aws_ec2_instance
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.main.id]
  subnet_id              = aws_subnet.subnet1.id

  associate_public_ip_address = true

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 30
    volume_type = "gp2"
  }

  user_data_base64 = base64encode(local.user_data)

  connection {
    host        = aws_instance.instance.public_ip
    user        = "ubuntu"
    password    = var.admin_password
    agent       = true
    private_key = file(var.private_key_path)
  }

  tags = merge(
    local.tags,
    {
      Name = local.aws_ec2_name
  })

  lifecycle {
    ignore_changes        = [tags, ebs_block_device]
    create_before_destroy = true
  }
}
