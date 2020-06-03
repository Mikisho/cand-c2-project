# TODO: Designate a cloud provider, region, and credentials
provider "aws" {
  region = "${var.region}"
}

# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2
resource "aws_instance" "udacity_t2" {
  count = 4
  ami = "ami-09d95fab7fff3776c"
  subnet_id = "subnet-08bfeacd6c020fb05"
  instance_type = "t2.micro"
  tags = {
    Name = "Udacity T2"
  }
}

# TODO: provision 2 m4.large EC2 instances named Udacity M4
resource "aws_instance" "udacity_m4" {
  count = 2
  ami = "ami-09d95fab7fff3776c"
  subnet_id = "subnet-08bfeacd6c020fb05"
  instance_type = "m4.large"
  tags ={
    Name = "Udacity M4"
  }
}