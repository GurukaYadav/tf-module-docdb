resource "aws_docdb_cluster_parameter_group" "pg" {
  family      = var.DOC_DB_PG_FAMILY
  name        = "${local.TAG_NAME}-docdb-pg"
  description = "docdb cluster parameter group"
}