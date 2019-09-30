resource "aws_route_table" "publicrt" {
  vpc_id = "${aws_vpc.mainvpc.id}"  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw_tf.id}"
  }
  tags = {
    Name = "PublicRouteTable_TF"
  }
  depends_on = ["aws_vpc.mainvpc","aws_internet_gateway.igw_tf"]
}

resource "aws_route_table_association" "publicroutetableassociation" {
  subnet_id      = "${aws_subnet.PublicSubnet.id}"
  route_table_id = "${aws_route_table.publicrt.id}"
  depends_on     = ["aws_subnet.PublicSubnet","aws_route_table.publicrt"]
}
