# ./rel/terraform/webhook_processor.tf

provider "aws" {
  region = "us-west-1" # Set the region available to you
}

# A security group is required to configure allowed traffic on the instance
resource "aws_security_group" "webhook_processor_sg" {
  name          = "allow-all-sg"
  description   = "Allow all inbound ssh+http traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# A key pair is required to ultimately allow SSH access
resource "aws_key_pair" "webhook_processor_kp" {
  key_name   = "webhook_processor_deploy"
  public_key = file("../webhook_processor_key.pub") # Read from the file we generated
}

# Finally, create the ec2 instance using the above references
resource "aws_instance" "webhook_processor" {
  ami             = "ami-0e4ae7403dc481431" # Debian Buster AMI
  instance_type   = "t2.micro" # Should be eligible for free
  key_name        = aws_key_pair.webhook_processor_kp.key_name
  security_groups = [aws_security_group.webhook_processor_sg.name]
}

output "webhook_processor_host" {
  value = aws_instance.webhook_processor.public_dns
}
