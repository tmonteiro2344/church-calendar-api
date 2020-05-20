resource "aws_ecs_task_definition" "main" {
  family = var.name

  container_definitions = <<CONTAINERS
[
  {
    "name": "api",
    "image": "${var.docker_repo}:${var.docker_tag}",
    "cpu": 256,
    "memory": 1024,
    "memoryReservation": 128,
    "essential": true,
    "portMappings": [
        {
            "containerPort": 80,
            "protocol": "tcp"
        }
    ],
    "logConfiguration": ${var.logConfiguration}
  }
]
CONTAINERS
}
