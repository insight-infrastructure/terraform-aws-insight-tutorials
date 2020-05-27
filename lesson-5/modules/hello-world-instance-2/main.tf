resource "random_pet" "this" {}

locals {
  attach_eip = var.instance_count == 1 ? true : false
}

resource "aws_eip" "this" {
  count = var.create && local.attach_eip ? 1 : 0 # lesson #6
}

resource "aws_eip_association" "this" {
  count = var.create && local.attach_eip ? 1 : 0 # lesson #6

  instance_id = join("", aws_instance.this.*.id) # lesson #6
  public_ip   = join("", aws_eip.this.*.public_ip) # lesson #6
}

resource "aws_key_pair" "this" {
  count = var.create ? 1 : 0 # lesson #6
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
  count = var.create ? 1 : 0 # lesson #6

  name = random_pet.this.id

  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = [
      22,
      # ssh
      var.instance_port,
    ]

    content {
      from_port = ingress.value
      to_port = ingress.value
      protocol = "tcp"
      cidr_blocks = [
        "0.0.0.0/0"]
    }
  }

//  Don't forget eggress!!!!
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
}

resource "aws_instance" "this" {
  count = var.create ? var.instance_count : 0 # lesson #6

  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  key_name = join("", aws_key_pair.this.*.key_name)
  user_data = data.template_file.user_data.rendered
  vpc_security_group_ids = [join("", aws_security_group.this.*.id)]
  subnet_id = var.subnet_id

  tags = {
    Name = "lesson-3"
  }
}
