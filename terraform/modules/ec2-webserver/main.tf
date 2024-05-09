resource "aws_security_group" "_" {
  name        = "ec2-security-group-prod-sg"
  description = "EC2 security group (terraform-managed)"
  vpc_id      = var.VPC_ID

  ingress {
    from_port   = var.RDS_PORT
    to_port     = var.RDS_PORT
    protocol    = "tcp"
    description = "Postgres"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "Telnet"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "HTTP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    description = "HTTPS"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "tls_private_key" "_" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "_" {
  key_name   = "${var.NAME}-ec2-key"
  public_key = tls_private_key._.public_key_openssh
}

resource "aws_instance" "_" {
  instance_type          = "t2.micro"
  ami                    = var.AMI_ID

  key_name               = aws_key_pair._.key_name
  vpc_security_group_ids = [aws_security_group._.id]

  tags = {
    Name = var.NAME
  }

  user_data = <<-EOF
                #!/bin/bash
                sudo apt-get update
                sudo apt-get install ca-certificates curl unzip
                sudo install -m 0755 -d /etc/apt/keyrings
                sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
                sudo chmod a+r /etc/apt/keyrings/docker.asc
                echo \
                  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
                  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
                  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
                sudo apt-get update
                sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
                sudo usermod -aG docker ubuntu
              EOF
}

resource "aws_eip" "_" {
  instance = aws_instance._.id
  domain   = "vpc"
}

