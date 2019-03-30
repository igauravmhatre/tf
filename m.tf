provider "aws" {
  region = "us-east-2"
  access_key = "AKIASWULIKLATM25NKPY"
  secret_key = "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"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_subnet_ids" "Public" {
  vpc_id = "vpc-09defe5e5c459751d"
}

resource "aws_instance" "aws_instance" {
  count         = "2"
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  subnet_id     = "${element(data.aws_subnet_ids.Public.ids,count.index)}"

  tags = {
    Name = "HelloWorld"
  }
}
