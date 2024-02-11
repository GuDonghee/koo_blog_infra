output "application_sg_id" {
  description = "어플리케이션 서버를 위한 보안그룹 ID"
  value       = aws_security_group.application.id
}

output "application_ids" {
  description = "어플리케이션 EC2 아이디의 목록"
  value       = try(aws_instance.application.*.id, null)
}
