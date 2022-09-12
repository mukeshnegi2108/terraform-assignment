resource "aws_vpc" "custom-vpc" {
  cidr_block = var.vpc_cidr_range
  tags = merge(
    {
      Name = "${var.vpc_name}"
    },
  var.tags)
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.custom-vpc.id
  cidr_block        = var.subnet_cidr_range
  availability_zone = var.availability_zone
  tags = merge(
    {
      Name = "${var.subnet_name}"
    },
  var.tags)
}

resource "aws_route_table" "vpc-route-table" {
  vpc_id = aws_vpc.custom-vpc.id
  tags = merge(
    {
      Name = "${var.route_table_name}"
    },
  var.tags)
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.vpc-route-table.id
}

resource "aws_internet_gateway" "vpc-igw" {
  vpc_id = aws_vpc.custom-vpc.id
  tags = merge(
    {
      Name = "${var.igw_name}"
    },
  var.tags)
}

resource "aws_route" "internet-route" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.vpc-route-table.id
  gateway_id             = aws_internet_gateway.vpc-igw.id
}

