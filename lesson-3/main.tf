provider "aws" {
  region = "us-east-2"
}


// This is an elastic IP used to have a fixed IP that you can move around from instance to instance.
// It is often used in conjunction with a DNS record or for external firewalls. If you destroy the IP, it is lost
// forever so it is often useful to declare it outside of your instance and then pick it up as a data resource.
// Check lesson 4 for more details on that
resource "aws_eip" "this" {}

resource "aws_eip_association" "this" {
  instance_id = aws_instance.this.id
  public_ip   = aws_eip.this.public_ip
}

resource "aws_key_pair" "this" {
  public_key = file(var.public_key_path)
}


data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "template_file" "user_data" {
  template = file("${path.module}/user-data/user-data.sh")

  vars = {
    instance_text = var.instance_text
    instance_port = var.instance_port
  }
}

resource "aws_security_group" "this" {
  name = "lesson-3"
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = var.instance_port
    to_port   = var.instance_port
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "this" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  key_name = aws_key_pair.this.key_name
  vpc_security_group_ids = [aws_security_group.this.id]
  user_data = data.template_file.user_data.rendered

  tags = {
    Name = "lesson-3"
  }
}
