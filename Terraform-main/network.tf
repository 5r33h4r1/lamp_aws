resource "aws_vpc" "myproject_vpc" {
  cidr_block = "${var.vpc-fullcidr}"

  tags = {
    name = "${var.prefix}-vpc"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.myproject_vpc.id}"
}


resource "aws_subnet" "web" {
  vpc_id     = "${aws_vpc.myproject_vpc.id}"
  cidr_block = "${var.Subnet-web-CIDR}"

  availability_zone = "${data.aws_availability_zones.all.names[0]}"
  depends_on  = ["aws_internet_gateway.gw"]
  tags = {
    Name = "web"
  }
}

resource "aws_eip" "web" {
  count = "${var.vm_count}"
  vpc   = true
   depends_on  = ["aws_internet_gateway.gw"]
}



resource "aws_eip_association" "eip_assoc" {
  count = "${var.vm_count}"
  instance_id   = "${element(aws_instance.web.*.id, count.index)}"
  allocation_id = "${element(aws_eip.web.*.id, count.index)}"
}

//subnets.tf
resource "aws_route_table" "route-table-web" {
  vpc_id = "${aws_vpc.myproject_vpc.id}"
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }
  tags = {
    Name = "dev-env-route-table"
  }
}

resource "aws_route_table_association" "subnet-association" {
  subnet_id      = "${aws_subnet.web.id}"
  route_table_id = "${aws_route_table.route-table-web.id}"
}

