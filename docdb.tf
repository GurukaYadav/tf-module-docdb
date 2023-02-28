resource "aws_docdb_cluster" "docdb" {
  cluster_identifier = "${local.TAG_NAME}-docdb-cluster"
  engine             =  var.DOC_DB_ENGINE
  engine_version     =  var.DOC_DB_ENGINE_VERSION
  master_username    = jsondecode(data.aws_secretsmanager_secret_version.example.secret_string)["DOCDB_USER"]
  master_password    = jsondecode(data.aws_secretsmanager_secret_version.example.secret_string)["DOCDB_PASS"]
  db_cluster_parameter_group_name = aws_docdb_cluster_parameter_group.pg.name
  db_subnet_group_name = aws_docdb_subnet_group.docdb.name
  vpc_security_group_ids = [aws_security_group.docdb.id]
}

resource "aws_docdb_cluster_instance" "cluster_instances" {
  count              = 1
  identifier         = "${local.TAG_NAME}-docdb-instance"
  cluster_identifier = aws_docdb_cluster.docdb.id
  instance_class     = var.DOC_DB_INSTANCE_CLASS
}
