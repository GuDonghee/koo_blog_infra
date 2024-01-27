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
