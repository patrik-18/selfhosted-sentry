module "subnets" {
  source = "./modules/network"

  vpc_id            = module.my_vpc.vpc_id
  cidr_blocks       = [
                        "10.10.1.0/24",
                        "10.10.2.0/24",
                        "10.10.3.0/24",
                        "10.10.4.0/24",
                        "10.10.5.0/24",
                        "10.10.6.0/24",
                        "10.10.7.0/24",
                        "10.10.8.0/24"
                        ]
  availability_zones = [
                        "eu-central-1a",
                        "eu-central-1b",
                        "eu-central-1a",
                        "eu-central-1b",
                        "eu-central-1a",
                        "eu-central-1b",
                        "eu-central-1a",
                        "eu-central-1b"
                        ]
  names             = [
                        "private-subnet-1a",
                        "private-subnet-1b",
                        "public-subnet-1a",
                        "public-subnet-1b",
                        "db-private-subnet-1a",
                        "db-private-subnet-1b",
                        "eks-private-subnet-1a",
                        "eks-private-subnet-1b"
                        ]
}

module "route_tables_public" {
  source = "../../modules/route_tables"

  vpc_id      = module.my_vpc.vpc_id 
  subnet_ids  = [ module.subnets.public_subnet_1a_id,module.subnets.public_subnet_1b_id ]
  gateway_id  = aws_internet_gateway.igw.id
  name        = "public-rtb"
}

# Private RT A

resource "aws_route_table" "test_private_rtb_1a" {
  vpc_id      = module.my_vpc.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "private-rtb-1a"
  }
}

resource "aws_route_table_association" "test_private_rtb_1a_pr" {
  subnet_id       = module.subnets.private_subnet_1a_id
  route_table_id  = aws_route_table.test_private_rtb_1a.id
}

resource "aws_route_table_association" "test_private_rtb_1a_db" {
  subnet_id       = module.subnets.private_db_subnet_1a_id
  route_table_id  = aws_route_table.test_private_rtb_1a.id
}

resource "aws_route_table_association" "test_private_rtb_1a_ecs" {
  subnet_id       = module.subnets.private_ecs_subnet_1a_id
  route_table_id  = aws_route_table.test_private_rtb_1a.id
}


# Private RT B

resource "aws_route_table" "test_private_rtb_1b" {
  vpc_id      = module.my_vpc.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "private-rtb-1b"
  }
}

resource "aws_route_table_association" "test_private_rtb_1b_pr" {
  subnet_id       = module.subnets.private_subnet_1b_id
  route_table_id  = aws_route_table.test_private_rtb_1b.id
}

resource "aws_route_table_association" "test_private_rtb_1b_db" {
  subnet_id       = module.subnets.private_db_subnet_1b_id
  route_table_id  = aws_route_table.test_private_rtb_1b.id
}

resource "aws_route_table_association" "test_private_rtb_1b_ecs" {
  subnet_id       = module.subnets.private_ecs_subnet_1b_id
  route_table_id  = aws_route_table.test_private_rtb_1b.id
}

resource "aws_internet_gateway" "igw" {
  vpc_id    = module.my_vpc.vpc_id

  tags = {
    Name = "igw"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  depends_on    = [aws_internet_gateway.igw]
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = module.subnets.public_subnet_1a_id

  tags = {
    Name = "nat-gw"
  }
}

resource "aws_eip" "nat_eip" {
    vpc = true
}
