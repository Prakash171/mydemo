## Building All independent resource - VPC,SG,IG,EIP using the .tf Template !

resource "aws_vpc" "mainvpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "My_test_VPC_TF"
  }
}

resource "aws_security_group" "allow_ssh_http" {
  name        = "allow_ssh_http"
  description = "to allow ssh & http traffic"
  vpc_id      = "${aws_vpc.mainvpc.id}"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["98.210.199.252/32"]
  }
  
   ingress {
    from_port   = 8088
    to_port     = 8088
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  } 
  tags = {
    Name = "WebDMZ_TF"
  }
  depends_on = ["aws_vpc.mainvpc"]
}

resource "aws_internet_gateway" "igw_tf" {
  vpc_id = "${aws_vpc.mainvpc.id}"

  tags = {
    Name = "my_igw_TF"
  }
  depends_on = ["aws_vpc.mainvpc"]
}

resource "aws_eip" "EIP" {
  vpc    = true
  tags = {
    Name = "my_eip_TF"
  }
}


