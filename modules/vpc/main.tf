resource "aws_vpc" "medbridge_vpc" {
    cidr_block           = var.vpc_cidr
    enable_dns_hostnames = true
    enable_dns_support   = true

    tags = {
        Name       = "medbridge-vpc"
        Enviroment = "production"
        Project    = "medbridge-patient-portal"
        Compliance = "HIPAA"
    }
}

resource "aws_subnet" "public_subnet_1" {
    vpc_id                  = aws_vpc.medbridge_vpc.id
    cidr_block              = var.public_subnet_1_cidr
    availability_zone       = "us-east-1a"
    map_public_ip_on_launch = true

    tags = {
        Name       = "medbridge-public-subnet-1"
        Type       = "Public"
        Compliance = "HIPAA"
    }
}

resource "aws_subnet" "public_subnet_2" {
    vpc_id                  = aws_vpc.medbridge_vpc.id
    cidr_block              = var.public_subnet_2_cidr
    availability_zone       = "us-east-1b"
    map_public_ip_on_launch = true

    tags = {
        Name        = "medbridge-public-subnet-2"
        Type        = "Public"
        Compliance  = "HIPAA"
    }
}

resource "aws_subnet" "private_subnet_1" {
    vpc_id             = aws_vpc.medbridge_vpc.id
    cidr_block         = var.private_subnet_1_cidr
    availability_zone  = "us-east-1a"

    tags = {
        Name         = "medbridge-private-subnet_1"
        Type         = "Private"
        Compliance   = "HIPAA"
    }
}

resource "aws_subnet" "private_subnet_2" {
    vpc_id            = aws_vpc.medbridge_vpc.id
    cidr_block        = var.private_subnet_2_cidr
    availability_zone = "us-east-1b"

    tags = {
        Name        = "medbridge-private-subnet-2"
        Type        = "Private"
        Compliance  = "HIPAA"
    }
}

resource "aws_internet_gateway" "medbridge_igw" {
    vpc_id = aws_vpc.medbridge_vpc.id

    tags = {
        Name       = "medbridge_igw"
        Compliance = "HIPAA"
    }
}

resource "aws_eip" "nat_eip" {
    domain = "vpc"

    tags = {
        Name = "medbridge-nat-eip"
    }
}

resource "aws_nat_gateway" "medbridge_nat" {
    allocation_id = aws_eip.nat_eip.id
    subnet_id     = aws_subnet.public_subnet_1.id

    tags = {
        Name       = "medbridge-nat-gateway"
        Compliance = "HIPAA"
    }

    depends_on = [aws_internet_gateway.medbridge_igw]
}

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.medbridge_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.medbridge_igw.id
    }

    tags = {
        Name       = "medbridge-public-rt"
        Compliance = "HIPAA"
    }
}

resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.medbridge_vpc.id

    route {
        cidr_block     = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.medbridge_nat.id
    }

    tags = {
        Name       = "medbridge-private-rt"
        Compliance = "HIPAA"
    }
}

resource "aws_route_table_association" "public_rta_1" {
    subnet_id      = aws_subnet.public_subnet_1.id
    route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_rta_2" {
    subnet_id      = aws_subnet.public_subnet_2.id
    route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_rta_1" {
    subnet_id      = aws_subnet.private_subnet_1.id
    route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_rta_2" {
    subnet_id      = aws_subnet.private_subnet_2.id
    route_table_id = aws_route_table.private_rt.id
}