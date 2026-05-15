resource "aws_security_group" "alb_sg" {
    name        = "medbridge-alb-sg"
    description = "Security group for MedBridge ALB - allows HTTPS from internet"
    vpc_id      = var.vpc_id

    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow HTTPS from internet"
    }

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow HTTP from internet for redirect"
    }

    egress {
        from_port    = 0
        to_port      = 0
        protocol     = "-1"
        cidr_blocks  = ["0.0.0.0/0"]
        description  = "Allow all outbound"
    }

    tags = {
        Name         = "medbridge-alb-sg"
        Compliance   = "HIPAA"
    }
}

resource "aws_security_group" "ec2_sg" {
    name        = "medbridge-ec2-sg"
    description = "Security group for MedBridge EC2 - allows traffic from ALB only"
    vpc_id      = var.vpc_id

    ingress {
        from_port       = 80
        to_port         = 80
        protocol        = "tcp"
        security_groups = [aws_security_group.alb_sg.id]
        description     = "Allow HTTP from ALB only"
    }

    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
        description     = "Allow all outbound"
    }

    tags = {
        Name       = "medbridge-ec2-sg"
        Compliance = "HIPAA"
    }
}

resource "aws_security_group" "rds_sg" {
    name        = "medbridge-rds-sg"
    description = "Security group for MedBridge RDS - allows traffic from EC2 only"
    vpc_id      = var.vpc_id

    ingress {
        from_port       = 3306
        to_port         = 3306
        protocol        = "tcp"
        security_groups = [aws_security_group.ec2_sg.id]
        description     = "Allow MySQL from EC2 only"
    }

    tags = {
        Name       = "medbridge-rds-sg"
        Compliance = "HIPAA"
    }
}