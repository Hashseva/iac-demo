variable "ami_id" {
  description = "AMI factice; change à chaque commit (ex: ami-deadbeef)"
  type        = string
  default     = "ami-00000000"
}

provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  skip_credentials_validation = true
  endpoints {
    ec2 = "http://ip10-0-5-4-d33s769ntdlhbpdsdbag-4566.direct.lab-boris.fr"
  }
}

resource "aws_instance" "demo" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"
}

resource "aws_instance" "demo" {
  ami           = var.ami_id           # ← varie à chaque commit
  instance_type = "t2.micro"

  tags = {
    Name = "LocalStackDemo-${substr(var.ami_id, 4, 8)}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

output "instance_id" {
  value = aws_instance.demo.id
}
output "image_id" {
  value = var.ami_id
}

