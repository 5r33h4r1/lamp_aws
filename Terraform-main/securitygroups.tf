resource "aws_security_group" "web-sg" {
  name   = "web"
  vpc_id = "${aws_vpc.myproject_vpc.id}"
  tags = {
    Name = "FrontEnd"
  }
  description = "HTTP connection and SSH connection"

  ingress {
    from_port   = 0
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = "22"
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
