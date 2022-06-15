resource "aws_ecs_cluster" "wearslot" {

  name = "wearslot-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}
