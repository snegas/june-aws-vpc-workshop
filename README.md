# june-aws-vpc-workshop
In this repo you're going to find a VPC and underlying resources creation

## Usage example

```
provider "aws" {
  region = "us-east-1"
}

locals {
  vpc_cidr = "10.0.0.0/16"
}

module "vpc" {
  source = "./../june-aws-vpc-workshop"

  prefix = "june-workshop"
  vpc_cidr = local.vpc_cidr

  tags = {
    Environment = "test"
  }

  vpc_tags = {
    SomeVPCTag = "true"
  }

  public_subnets = {
    "a" = cidrsubnet(local.vpc_cidr, 4, 0)
    "b" = cidrsubnet(local.vpc_cidr, 4, 1)
  }

  private_subnets = {
    "a" = cidrsubnet(local.vpc_cidr, 4, 2)
    "b" = cidrsubnet(local.vpc_cidr, 4, 3)
  }

  db_subnets = {
    "a" = cidrsubnet(local.vpc_cidr, 4, 4)
    "b" = cidrsubnet(local.vpc_cidr, 4, 5)
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "public" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  key_name = "june-workshop"
  subnet_id = module.vpc.public_subnets.ids[0]

  tags = {
    Name = "public"
  }
}

resource "aws_instance" "private" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  key_name = "june-workshop"
  subnet_id = module.vpc.private_subnets.ids[0]

  tags = {
    Name = "private"
  }
}


resource "aws_instance" "db" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  key_name = "june-workshop"
  subnet_id = module.vpc.db_subnets.ids[0]

  tags = {
    Name = "db"
  }
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| assign\_public\_ips\_on\_launch | Will resources in public subnets get public IP during creation? | `bool` | `true` | no |
| create\_dynamodb\_vpc\_endpoint | Create VPC enpoint associated with private subnets | `bool` | `true` | no |
| create\_s3\_vpc\_endpoint | Create VPC enpoint associated with private subnets | `bool` | `true` | no |
| create\_secrets\_manager\_vpc\_endpoint | Create VPC enpoint associated with private subnets | `bool` | `true` | no |
| custom\_eips\_for\_nat | Pass custom EIPs if you have some already, otherwise they will be created by the module | `map(string)` | `{}` | no |
| db\_subnet\_tags | Tags which are going to be attached to all DB subnets | `map(string)` | `{}` | no |
| db\_subnets | CIDR blocks for subnets | `map(string)` | `{}` | no |
| enable\_dns\_hostnames | Enable/disable DNS Hostnames in the VPC | `bool` | `false` | no |
| enable\_dns\_support | Enable/disable DNS Support in the VPC | `bool` | `true` | no |
| enable\_vpc | Create VPC or not? | `bool` | `true` | no |
| prefix | Prefix to all resources in the module | `string` | n/a | yes |
| private\_subnet\_tags | Tags which are going to be attached to all private subnets | `map(string)` | `{}` | no |
| private\_subnets | CIDR blocks for subnets | `map(string)` | `{}` | no |
| public\_subnet\_tags | Tags which are going to be attached to all public subnets | `map(string)` | `{}` | no |
| public\_subnets | CIDR blocks for subnets | `map(string)` | `{}` | no |
| subnet\_tags | Tags which are going to be attached to all subnets | `map(string)` | `{}` | no |
| tags | Tags which are going to be attached to all resources | `map(string)` | `{}` | no |
| vpc\_cidr | Valid AWS VPC CIDR block | `string` | n/a | yes |
| vpc\_tags | Tags which are going to be attached to VPC resource only | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| db\_subnets | n/a |
| private\_subnets | n/a |
| public\_subnets | n/a |
| this\_vpc\_id | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->