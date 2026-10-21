resource "aws_instance" "GenKey_server" {
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.GenKey_SG.id]
  key_name               = "id_rsa"
  tags = {
    Name = "GenKey Server"
  }

}
resource "aws_security_group" "GenKey_SG" {
  name = "GenKey-SG"
  #SSH
  ingress {
    description = "For SSH"
    from_port   = var.GenKey_ports[0]
    to_port     = var.GenKey_ports[0]
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #HTTP
  ingress {
    description = "For HTTP"
    from_port   = var.GenKey_ports[1]
    to_port     = var.GenKey_ports[1]
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "For All Port"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
