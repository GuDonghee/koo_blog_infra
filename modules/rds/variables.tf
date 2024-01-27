variable "rds_instance" {
  description = "RDS 인스턴스를 위한 설정 값 목록입니다,"
  type        = map(string)
  default     = {}
}

variable "subnet_group_name" {
  description = "RDS 서브넷 그룹의 이름입니다."
  type        = string
}
