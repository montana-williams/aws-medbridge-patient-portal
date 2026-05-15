output "alb_sg_id" {
    description = "Security group ID for the ALB"
    value       = aws_security_group.alb_sg.id
}

output "ec2_sg_id" {
    description = "Security group ID for EC2"
    value       = aws_security_group.ec2_sg.id
}

output "rds_sg_id" {
    description = "Security group ID for RDS"
    value       = aws_security_group.rds_sg.id
}