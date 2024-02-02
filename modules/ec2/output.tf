output "application_sg_id" {
  description = "어플리케이션 서버를 위한 보안그룹 ID"
  value       = aws_security_group.application.id
}