output "vpc_id" {
  description = "VPC의 ID"
  value       = aws_vpc.koo-blog.id
}

output "public_subnet_ids" {
  description = "퍼블릭 서브넷 아이디의 목록"
  value       = try(aws_subnet.public.*.id, null)
}

output "private_subnet_ids" {
  description = "프라이빗 서브넷 아이디의 목록"
  value       = try(aws_subnet.private.*.id, null)
}
