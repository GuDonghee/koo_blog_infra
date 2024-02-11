variable "vpc_cidr" {
  description = "VPC의 IPv4 CIDR 입니다."
  type        = string
}

variable "vpc_name" {
  description = "VPC의 이름 입니다."
  type        = string
}

variable "public_subnets" {
  description = "Public 서브넷의 설정 값 목록입니다."
  type        = map(list(string))
  default     = {}
}

variable "private_subnets" {
  description = "Private 서브넷의 설정 값 목록입니다."
  type        = map(list(string))
  default     = {}
}

variable "application_ids" {
  description = "Application EC2 인스턴스를 실행 할 서브넷 ID 입니다."
  type        = list(string)
}
