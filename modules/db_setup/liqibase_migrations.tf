resource "kubernetes_namespace" "liquibase_namespace" {
  metadata {
    name = "liquibase-migrations"
  }
}

resource "helm_release" "liquibase" {
  name       = "liquibase-migrations"
  chart      = "liquibase_migrations"
  repository = "./helm"
  version    = "0.1.0"
  namespace  = "liquibase-migrations"

  set = [
    {
      name  = "host"
      value = aws_db_instance.illuminati_db.address
    },
    {
      name  = "port"
      value = aws_db_instance.illuminati_db.port
    },
    {
      name  = "databaseName"
      value = aws_db_instance.illuminati_db.db_name
    },
    {
      name  = "user"
      value = aws_db_instance.illuminati_db.username
    },
    {
      name  = "password"
      value = aws_db_instance.illuminati_db.password
    }
  ]

  depends_on = [aws_db_instance.illuminati_db, kubernetes_namespace.liquibase_namespace]

}
