resource "aws_vpc" "myproject_vpc" {
  cidr_block = "${var.vpc-fullcidr}"

  tags = {
    name  = "${var.prefix}-vpc"
  }
}


resource "aws_subnet" "web" {
  vpc_id     = "${aws_vpc.myproject_vpc.id}"
  cidr_block = "${var.Subnet-web-CIDR}"
  tags = {
    Name = "web"
  }
  availability_zone = "${data.aws_availability_zones.all.names[0]}"
}


resource "aws_route_table_association" "web" {
  subnet_id      = "${aws_subnet.web.id}"
  route_table_id = "${aws_route_table.public.id}"
}

/* EXTERNAL NETWORG , IG, ROUTE TABLE */
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.myproject_vpc.id}"
  tags = {
    Name = "internet gw terraform generated"
  }
}
// resource "aws_network_acl" "all" {
//   vpc_id = "${aws_vpc.myproject_vpc.id}"
//   egress {
//     protocol   = "-1"
//     rule_no    = 2
//     action     = "allow"
//     cidr_block = "0.0.0.0/0"
//     from_port  = 0
//     to_port    = 0
//   }
//   ingress {
//     protocol   = "-1"
//     rule_no    = 1
//     action     = "allow"
//     cidr_block = "0.0.0.0/0"
//     from_port  = 0
//     to_port    = 0
//   }
//   tags = {
//     Name = "open acl"
//   }
// }
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.myproject_vpc.id}"
  tags = {
    Name = "Public"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }
}
resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.myproject_vpc.id}"
  tags =  {
    Name = "Private"
  }
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.web.id}"
  }
}
resource "aws_eip" "forNat" {
  vpc = true
}
resource "aws_nat_gateway" "web" {
  allocation_id = "${aws_eip.forNat.id}"
  subnet_id     = "${aws_subnet.web.id}"
  depends_on    = ["aws_internet_gateway.gw"]
}
