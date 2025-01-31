resource "aws_subnet" "subnet" {
  count = length(var.cidr_blocks)

  vpc_id            = var.vpc_id
  cidr_block        = var.cidr_blocks[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = var.names[count.index]
  }
}

output "private_subnet_1a_id" {
  description = "private-subnet-1a"
  value       = aws_subnet.subnet[0].id
}
output "private_subnet_1b_id" {
  description = "private-subnet-12"
  value       = aws_subnet.subnet[1].id
}
output "public_subnet_1a_id" {
  description = "public-subnet-1a"
  value       = aws_subnet.subnet[2].id
}
output "public_subnet_1b_id" {
  description = "public-subnet-1b"
  value       = aws_subnet.subnet[3].id
}

output "private_db_subnet_1a_id" {
  description = "db-private-subnet-1a"
  value       = aws_subnet.subnet[4].id
}
output "private_db_subnet_1b_id" {
  description = "db-private-subnet-1b"
  value       = aws_subnet.subnet[5].id
}

output "private_eks_subnet_1a_id" {
  description = "eks-private-subnet-1a"
  value       = aws_subnet.subnet[6].id
}
output "private_eks_subnet_1b_id" {
  description = "eks-private-subnet-1a"
  value       = aws_subnet.subnet[7].id
}