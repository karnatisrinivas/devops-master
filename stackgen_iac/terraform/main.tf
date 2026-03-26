module "stackgen_103d6938-d6ea-427f-986a-e055ad532c6b" {
  source      = "./modules/aws_sg"
  description = "Managed by Terraform."
  egress      = []
  ingress     = []
  name        = "myapp-security-group"
  tags        = {}
  vpc_id      = aws_vpc.vpc-main.id
  depends_on  = [module.stackgen_f1a9756f-e01d-4397-8a4a-ce522f1f6ac6]
}

module "stackgen_5eddb6bf-b7e8-4516-b779-88e84b1943ac" {
  source                  = "./modules/aws_subnet"
  availability_zone       = null
  cidr_block              = null
  map_public_ip_on_launch = false
  tags = {
    Name = "subnet1"
  }
  vpc_id     = aws_vpc.vpc-main.id
  depends_on = [module.stackgen_cad51ffa-7c4e-49d4-8206-d3cb0112851e, module.stackgen_f1a9756f-e01d-4397-8a4a-ce522f1f6ac6]
}

module "stackgen_cad51ffa-7c4e-49d4-8206-d3cb0112851e" {
  source                               = "./modules/aws_vpc"
  cidr_block                           = "10.0.0.0/16"
  enable_dns_hostnames                 = false
  enable_dns_support                   = true
  enable_network_address_usage_metrics = false
  instance_tenancy                     = "default"
  tags = {
    Name = "mtaoo"
  }
  depends_on = [module.stackgen_103d6938-d6ea-427f-986a-e055ad532c6b]
}

module "stackgen_f1a9756f-e01d-4397-8a4a-ce522f1f6ac6" {
  source                = "./modules/aws_ec2"
  ami                   = "ami-0d6d5a1f326b57cb0"
  enable_public_ip      = false
  instance_type         = "t2.micro"
  key_name              = "test"
  root_volume_encrypted = true
  root_volume_size      = 30
  root_volume_type      = "gp2"
  security_group_ids    = ["aws.main.id"]
  subnet_id             = "$${aws_subnet.this.id}"
  tags                  = {}
  user_data             = null
}

