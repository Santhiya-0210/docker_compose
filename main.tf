provider "AWS" {
 region = "us_east_1"
   }
resource "aws_key_pair" "my_key"{
  key_name = "jenkins"
  path = file("/~/.ssh/id_rsa.pub")
  }
resource "aws_security_group" "allow_ssh"  {
   name  = "allow_ssh"
   description  = "allow ssh access"
ingress  {
  from_port = 22
  to_port  = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
egress  {
  from_port = 22
  to_port  = 22
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  }
}
resource  "aws_instance" "My_ec2"  {
  ami  = "ami-0e2c8caa4b6378d8c"
  instance_type = "t2.micro"
  key_name = aws_key_pair.my_key.key_name
  security_groups = [
     aws_security_group.allow_ssh.name,
     ]
  }

Tag = { 
name = "Terraform.script"
}

  
  
