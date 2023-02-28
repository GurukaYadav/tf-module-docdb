resource "aws_docdb_cluster_parameter_group" "pg" {
  family      = var.PG_FAMILY
  name        = "${local.TAG_NAME}-pg"
  description = "docdb cluster parameter group"
}