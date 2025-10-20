# CloudWatch log group for container logs
resource "aws_cloudwatch_log_group" "app" {
  name              = "/ecs/${var.project_name}"
  retention_in_days = 14
}

# ECS cluster
resource "aws_ecs_cluster" "this" {
  name = "service-navy-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = { Project = var.project_name }
}


resource "aws_ecs_task_definition" "this" {
  family                   = "service-navy-td"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = tostring(var.cpu)    # 0.25 vCPU
  memory                   = tostring(var.memory) # 512 MiB
  execution_role_arn       = aws_iam_role.task_execution_role.arn
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = var.container_image
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.host_port
          protocol      = "tcp"
          appProtocol   = "http"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-region        = var.region
          awslogs-group         = aws_cloudwatch_log_group.app.name
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])

  tags = { Project = var.project_name }
}

# ECS Service with public IP
resource "aws_ecs_service" "this" {
  name            = "${var.project_name}-svc"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  platform_version = "LATEST"
  force_new_deployment = true

  network_configuration {
    assign_public_ip = true
    security_groups  = [aws_security_group.svc_sg.id]
    subnets          = [for s in aws_subnet.public : s.id]
  }

  # Without a load balancer. If you later add an ALB, add a 'load_balancer' block and target group.
  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent         = 200

  tags = { Project = var.project_name }

  depends_on = [
    aws_iam_role_policy_attachment.task_exec_managed
  ]
}