variable "aws_ami" {
  description = "Bastion에 사용될 AWS AMI입니다."
  type        = string
}

variable "vpc_name" {
  description = "VPC의 이름 입니다."
  type        = string
}

variable "vpc_id" {
  description = "VPC의 ID 입니다."
  type        = string
}

variable "subnet_id" {
  description = "Bastion EC2 인스턴스를 실행 할 퍼블릭 서브넷 ID 입니다."
  type        = string
}

variable "instance_type" {
  description = "Bastion EC2 인스턴스 타입입니다."
  type        = string
}
