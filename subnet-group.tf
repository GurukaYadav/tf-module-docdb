resource "aws_docdb_subnet_group" "docdb" {
  name       = "${local.TAG_NAME}-docdb-subnet-group"
  subnet_ids = var.PRIVATE_SUBNET_ID

  tags = {
    Name = "${local.TAG_NAME}-docdb-subnet-group"
  }
}