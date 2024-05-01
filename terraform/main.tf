data "aws_vpc" "default" {
  default = true
}
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

module "database_prod" {
  source = "./modules/db"

  INSTANCE_IDENTIFIER    = "${var.APP_NAME}-prod"
  DB_USERNAME            = var.PROD_DB_USERNAME
  DB_PASSWORD            = var.PROD_DB_PASSWORD
  VPC_ID = data.aws_vpc.default.id
  is_publicly_accessible = true
}

module "webserver_prod" {
  source = "./modules/ec2-webserver"

  NAME     = "${var.APP_NAME}-prod"
  AMI_ID   = data.aws_ami.ubuntu.id
  VPC_ID   = data.aws_vpc.default.id
  RDS_PORT = var.PROD_DB_PORT
}

resource "aws_route53_record" "www" {
  zone_id = var.HOSTED_ZONE_ID
  name    = var.DOMAIN_NAME
  type    = "A"
  ttl     = 300
  records = [module.webserver_prod.instance_public_ip]
}