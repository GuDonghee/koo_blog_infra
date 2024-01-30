variable "rds_instance" {
  description = "RDS 인스턴스를 위한 설정 값 목록입니다,"
  type        = map(string)
  default     = {}
}

variable "subnet_group_name" {
  description = "RDS 서브넷 그룹의 이름입니다."
  type        = string
}

variable "private_subnet_ids" {
  description = "RDS 서브넷 그룹에 해당하는 서브넷 ID 목록 입니다."
  type        = list(string)
}

variable "vpc_name" {
  description = "VPC의 이름 입니다."
  type        = string
}

variable "vpc_id" {
  description = "VPC의 ID 입니다."
  type        = string
}

variable "application_sg_id" {
  description = "어플리케이션 보안그룹 ID 입니다."
  type        = string
}
