resource "aws_instance" "PublicEC2" {
  ami = "ami-046a1b56e73cdd0e2" 
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.allow_ssh_http.id}"]
  subnet_id = "${aws_subnet.PublicSubnet.id}"
  key_name = "sai-key-pair"
  tags = {
    Name = "WebApp-Server-TF"
  }

  user_data = <<-EOF
                  #!/bin/bash
                  yum update -y
                  systemctl start docker
                  sudo usermod -aG docker ec2-user
                  newgrp docker
                  cd /home/ec2-user/sample
                  ifconfig | grep "eth[0-9]" -A 1 | awk 'FNR == 2{print $2}' > ip.txt
                  sed -i "s/localhost/$(cat ip.txt)/g" flaskapp.py
                  sed -i "s/localhost/$(cat ip.txt)/g" docker-compose.yml
                  docker-compose up > log.txt 
                  EOF

  depends_on = ["aws_vpc.mainvpc","aws_subnet.PublicSubnet","aws_security_group.allow_ssh_http"]
}
