resource "aws_ecs_cluster" "main_ecs" {
  name = "Pawsandclaws-ecs-${var.workspace}"
  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = merge(
    {
      "Name" : "ECS-cluster-${var.workspace}"
  }, var.default_tags)
}
