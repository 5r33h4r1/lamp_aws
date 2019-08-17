
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
  count = "${var.vm_count}"
  availability_zone = "us-west-2a"
  size              = 40

  tags = {
    Name = "${var.prefix}-disk"
  }
}


resource "aws_volume_attachment" "ebs_att" {
  count = "${var.vm_count}"
  device_name = "/dev/sdh"
  volume_id   = "${element(aws_ebs_volume.ebs.*.id, count.index)}"
  instance_id = "${element(aws_instance.web.*.id, count.index)}"
}


resource "aws_instance" "web" {
  count           = "${var.vm_count}"
  ami             = "${data.aws_ami.ubuntu.id}"
  instance_type   = "${var.ec2_instance_type}"
  subnet_id = "${aws_subnet.web.id}"
  vpc_security_group_ids = ["${aws_security_group.web-sg.id}"]
  key_name        = "${var.key_pair}"
  user_data       = "${data.template_file.setup.rendered}"

  tags = {
    Name = "${var.prefix}-web-${count.index}"
  }
}
