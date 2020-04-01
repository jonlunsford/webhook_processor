# ./terraform/webhook_processor.tf

provider "aws" {
  region = "us-west-1"
}

resource "aws_instance" "webhook_processor" {
  ami           = "ami-040dfc3ebf1bfc4f6" # Ubuntu 18.04
  instance_type = "t2.micro"
}

output "webhook_processor_host" {
  value = "${aws_instance.webhook_processor.public_dns}"
}

