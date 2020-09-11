resource "google_sql_database" "database" {
  name     = "mydatabase"
  instance = google_sql_database_instance.instance.name
  provider = google.for-production
}

resource "google_sql_database_instance" "instance" {
  name   = "mysql-database12"
  provider = google.for-production
  region = "us-east1"
  project = var.prod_projectID
  database_version = "MYSQL_5_7"
  settings {
    tier = "db-f1-micro"
    disk_size = 10
    disk_type = "PD_SSD"
    ip_configuration {
      ipv4_enabled    = true

      authorized_networks  {
      value = "0.0.0.0/0"
    }
    }
    }
}

resource "google_sql_user" "users" {
  name     = "root"
  instance = google_sql_database_instance.instance.name
  password = var.sql_root_password
  provider = google.for-production
  project = var.prod_projectID

}