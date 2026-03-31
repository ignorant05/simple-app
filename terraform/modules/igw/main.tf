resource "aws_internet_gateway" "main" {
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.cluster_name}-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }


  tags = {
    Name = "$(var.cluster_name)-rt-public"
  }
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = var.public_subnet_a_id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = var.public_subnet_b_id
  route_table_id = aws_route_table.public.id
}
