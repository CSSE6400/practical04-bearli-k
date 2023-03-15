terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 4.0"
        }
    }
}

provider "aws" {
    region = "us-east-1"
    shared_credentials_files = ["./credentials"]
}

resource "aws_instance" "hextris-server" {
    ami = "ami-005f9685cb30f234b"
    instance_type = "t2.micro"

    tags = {
        Name = "hextris"
    }
}

user_data = file("./serve-hextris.sh")

output "hextris-url" {
    value = aws_instance.hextris-server.public_ip
}