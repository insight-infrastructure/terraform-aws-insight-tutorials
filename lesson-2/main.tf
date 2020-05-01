
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

resource "aws_security_group" "this" {
  name = "lesson-2"
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "this" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

//  Note: NEVER use security_groups, always vpc_security_group_ids to attach SGs. security_groups forces diff
//  to recreate resource.
//  TODO: Extra work -> Try this out and then never do it again ;)
  vpc_security_group_ids = [aws_security_group.this.id]

  tags = {
    Name = "lesson-2"
  }
}

// TODO: Extra work -> Uncomment this and reapply.  Why can you not ssh in now with the output public IP?
//resource "aws_eip" "this" {}
//
//resource "aws_eip_association" "this" {
//  instance_id = aws_instance.this.id
//  public_ip   = aws_eip.this.public_ip
//}
