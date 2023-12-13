/*resource "aws_route_table" "default_route_table" {
    vpc_id = module.vpc.vpc_id
}

resource "aws_route" "myigw_route" {
    route_table_id         = aws_route_table.default_route_table.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = aws_internet_gateway.internet_gw.id
}

resource "aws_route_table_association" "Mysubnet01_association" {
    route_table_id = aws_route_table.default_route_table.id
    subnet_id      = module.vpc.private_subnets[0]
}


resource "aws_route_table_association" "Mysubnet02_association" {
    route_table_id = aws_route_table.default_route_table.id
    subnet_id      = module.vpc.private_subnets[1]
    
}*/