
data "template_file" "setup" {
  template = "${file("${path.module}/Templates/cloudinit.tpl")}"
}


data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_availability_zones" "all" {}

resource "aws_ebs_volume" "ebs" {
  availability_zone = "us-west-2a"
  size              = 40

  tags = {
    Name = "${var.prefix}-disk"
  }
}


resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = "${aws_ebs_volume.ebs.id}"
  instance_id = "${aws_instance.web.id}"
}


resource "aws_instance" "web" {
  count                  = "${var.vm_count}"
  ami                    = "${data.aws_ami.ubuntu.id}"
  instance_type          = "${var.ec2_instance_type}"
  key_name               = "${var.key_pair}"
  user_data              = "${data.template_file.setup.rendered}"
  security_groups =    ["${aws_security_group.web-sg.name}"]

  tags {
    Name = "${var.prefix}-web-${count.index}"
  }
}
