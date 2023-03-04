resource "null_resource" "web" {

  provisioner "local-exec" {
    command = <<EOF
curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip"
cd /tmp
unzip -o mongodb.zip
cd mongodb-main
mongo --tls --host aws_docdb_cluster.docdb.endpoint:27017 --tlsCAFile /root/rds-combined-ca-bundle.pem  --username jsondecode(data.aws_secretsmanager_secret_version.secret.secret_string)["DOCDB_USER"] --password jsondecode(data.aws_secretsmanager_secret_version.secret.secret_string)["DOCDB_PASS"] < catalogue.js
mongo --tls --host aws_docdb_cluster.docdb.endpoint:27017 --tlsCAFile /root/rds-combined-ca-bundle.pem  --username jsondecode(data.aws_secretsmanager_secret_version.secret.secret_string)["DOCDB_USER"] --password jsondecode(data.aws_secretsmanager_secret_version.secret.secret_string)["DOCDB_PASS"] < users.js
EOF
  }
}