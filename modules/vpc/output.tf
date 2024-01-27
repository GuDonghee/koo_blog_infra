output "vpc_id" {
  description = "VPC의 ID"
  value       = aws_vpc.this.id
}

output "application_sg_id" {
  description = "어플리케이션 서버를 위한 보안그룹 ID"
  value       = aws_security_group.application.id
}

output "private_subnet_ids" {
  description = "프라이빗 서브넷 아이디의 목록"
  value       = try(aws_subnet.private.*.id, null)
}
