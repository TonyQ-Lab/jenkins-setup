resource "aws_instance" "server" {
  ami                    = "ami-0e2c8caa4b6378d8c"
  instance_type          = "t3.small"
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids
  key_name               = "linux-kp"
  root_block_device {
    volume_size = 12
  }
  tags = {
    Name = var.instance_name
  }
}

resource "aws_eip" "server_eip" {
  depends_on = [aws_instance.server]
  instance   = aws_instance.server.id
  tags = {
    Name = "${var.instance_name}-eip"
  }
}