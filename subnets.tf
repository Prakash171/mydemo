resource "aws_subnet" "PublicSubnet" {
  vpc_id                  = "${aws_vpc.mainvpc.id}"
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "Pub-Subnet-TF"
  }
  depends_on = ["aws_vpc.mainvpc"]
}

#resource "aws_subnet" "PrivateSubnet" {
#  vpc_id                  = "${aws_vpc.mainvpc.id}"
#  cidr_block              = "10.0.16.0/20"
#  availability_zone       = "us-west-2a"
#  tags = {
#    Name = "Priv-Subnet-TF"
#  }
#  depends_on = ["aws_vpc.mainvpc"]
#}

