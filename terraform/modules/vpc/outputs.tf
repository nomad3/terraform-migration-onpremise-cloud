output "default_security_group_id" {
  description = "Default security group ID"
  value       = aws_security_group.default_sg.id
}
