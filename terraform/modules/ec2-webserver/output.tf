output "instance_public_ip" {
  description = "The instance public ip"
  value       = aws_eip._.public_ip
}