resource "aws_docdb_cluster" "docdb" {
  cluster_identifier = "${local.TAG_NAME}-cluster"
  engine             =  var.ENGINE
  engine_version     =  var.ENGINE_VERSION
  master_username    = jsondecode(data.aws_secretsmanager_secret_version.secret.secret_string)["DOCDB_USER"]
  master_password    = jsondecode(data.aws_secretsmanager_secret_version.secret.secret_string)["DOCDB_PASS"]
  db_cluster_parameter_group_name = aws_docdb_cluster_parameter_group.pg.name
  db_subnet_group_name = aws_docdb_subnet_group.docdb.name
  vpc_security_group_ids = [aws_security_group.docdb.id]
}

resource "aws_docdb_cluster_instance" "cluster_instances" {
  count              = var.NO_OF_NODES
  identifier         = "${local.TAG_NAME}-instance"
  cluster_identifier = aws_docdb_cluster.docdb.id
  instance_class     = var.INSTANCE_CLASS
}
