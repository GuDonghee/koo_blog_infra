resource "aws_lb" "alb" {
  name               = "${var.vpc_name}-alb"
  load_balancer_type = "application"
  subnets            = [
    aws_subnet.public[0].id,
    aws_subnet.public[1].id
  ]

  security_groups = [aws_security_group.alb.id]

  tags = {
    Name      = "${var.vpc_name}-alb"
    ManagedBy = "Terraform"
  }
}

resource "aws_security_group" "alb" {

  description = "Access for the EC2 Application Server"
  name        = "${var.vpc_name}-alb-security"
  vpc_id      = aws_vpc.koo-blog.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "${var.vpc_name}-alb-security"
    ManagedBy = "Terraform"
  }
}

resource "aws_lb_target_group" "alb" {

  name        = "${var.vpc_name}-alb-target-group"
  port        = "8080"
  protocol    = "HTTP"
  vpc_id      = aws_vpc.koo-blog.id

  health_check {
    path                = "/"
    matcher             = "400-499"
    unhealthy_threshold = 10
  }

  tags = {
    Name      = "${var.vpc_name}-alb-target-group"
    ManagedBy = "Terraform"
  }
}

resource "aws_lb_target_group_attachment" "alb" {
  count            = length(var.application_ids)
  target_group_arn = aws_lb_target_group.alb.arn
  target_id        = var.application_ids[count.index]
  port             = 8080
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "지원하지 않는 CONTENT-TYPE 헤더 형식입니다."
      status_code  = "400"
    }
  }

  tags = {
    Name      = "${var.vpc_name}-alb-http-listener"
    ManagedBy = "Terraform"
  }
}

resource "aws_lb_listener_rule" "http" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb.arn
  }

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  tags = {
    Name      = "${var.vpc_name}-alb-http-listener-rule"
    ManagedBy = "Terraform"
  }
}
