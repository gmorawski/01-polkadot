locals {

  azs = slice(data.aws_availability_zones.available.names, 0, 2)

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

##################
# EC2 modules
##################

# Create ec2 instance in private subnet of the AZ1
module "polkadot-az1" {
  source = "terraform-aws-modules/ec2-instance/aws"
  count  = 1
  name   = "polkadot-az1-$(count.index)"

  ami           = var.ami
  instance_type = "c6i.4xlarge"
  key_name      = "user1"
  monitoring    = true
  subnet_id     = module.vpc.private_subnets[0]

  tags = local.tags
}

# Create ec2 instance in private subnet of the AZ2
module "polkadot-az2" {
  source = "terraform-aws-modules/ec2-instance/aws"
  count  = 1
  name   = "polkadot-az2-$(count.index)"

  ami           = var.ami
  instance_type = "c6i.4xlarge"
  key_name      = "user1"
  monitoring    = true
  subnet_id     = module.vpc.private_subnets[1]

  tags = local.tags

}

# EBS volume of size 1 TB to be attached to ec2 instance as a prerequisite
resource "aws_volume_attachment" "ebs_az1" {
  count       = 1
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebs_az1[count.index].id
  instance_id = module.polkadot-az1[count.index].id
}

resource "aws_ebs_volume" "ebs_az1" {
  count             = 1
  availability_zone = element(local.azs, 0)
  size              = 1000

  tags = local.tags
}

resource "aws_volume_attachment" "ebs_az2" {
  count       = 1
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebs_az2[count.index].id
  instance_id = module.polkadot-az1[count.index].id
}

resource "aws_ebs_volume" "ebs_az2" {
  count             = 1
  availability_zone = element(local.azs, 1)
  size              = 1000

  tags = local.tags
}