# Jenkins ALB creation 
resource "aws_lb" "alb" {
  name                       = var.alb_name
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = var.security_group_ids
  subnets                    = var.alb_subnets_ids
  enable_deletion_protection = false

  tags = {
    Environment = var.alb_name
  }
}

# Instance target group
# Instance target group
resource "aws_lb_target_group" "alb_tg" {
  name     = var.tg_name  # Uses updated tg_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.alb_vpc_id
}


# Attach instance to target group
resource "aws_lb_target_group_attachment" "attach-tg" {
  target_group_arn = aws_lb_target_group.alb_tg.arn
  target_id        = var.ec2_instance_id
  port             = 3000
}

# HTTP listener
resource "aws_lb_listener" "HTTP" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}

# HTTPS listener
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}

