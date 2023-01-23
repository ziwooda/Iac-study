resource "aws_lb" "tf-exlb" {
  name               = "external-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.ex_sg_id]
  subnets            = var.ex_subnet_ids

  enable_deletion_protection = false

  tags = {
    Environment = "${var.env}"
  }
}

resource "aws_lb_target_group" "exlb-target" {
  name     = "ex-lb-target"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  
  health_check {
    enabled = true
    path = "/"

    protocol = "HTTP"
    port = 80
    healthy_threshold = 5
    unhealthy_threshold = 2
    interval = 300
    timeout = 5
    matcher = 200
  }
}

resource "aws_lb_listener" "exlb-listener" {
  load_balancer_arn = aws_lb.tf-exlb.arn
  port              = "80"
  protocol          = "HTTP"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.exlb-target.arn
  }
}

resource "aws_lb_target_group_attachment" "ex-target-attachment" {
  count            = length(var.ex_target_instance)
  target_group_arn = aws_lb_target_group.exlb-target.arn
  target_id        = "${element(var.ex_target_instance, count.index)}"
  port             = 80
}

resource "aws_lb" "tf-inlb" {
  name               = "internall-lb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [var.in_sg_id]
  subnets            = var.in_subnet_ids

  enable_deletion_protection = false

  tags = {
    Environment = "${var.env}"
  }
}

resource "aws_lb_target_group" "inlb-target" {
  name     = "in-lb-target"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  
  health_check {
    enabled = true
    path = "/"

    protocol = "HTTP"
    port = 8080
    healthy_threshold = 5
    unhealthy_threshold = 2
    interval = 300
    timeout = 5
    matcher = 200
  }
}

resource "aws_lb_listener" "inlb-listener" {
  load_balancer_arn = aws_lb.tf-inlb.arn
  port              = "8080"
  protocol          = "HTTP"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.inlb-target.arn
  }
}