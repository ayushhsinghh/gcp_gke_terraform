//Creating PVC for WordPress Pod
resource "kubernetes_persistent_volume_claim" "wp-pvc1" {
  metadata {
    name = "wp-pvc"
    labels = {
      env     = "Production"
      Country = "India"
    }
  }

  wait_until_bound = false
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "5Gi"
      }
    }
  }
}


//Creating Deployment for WordPress
resource "kubernetes_deployment" "wp-dep" {
  metadata {
    name = "wp-dep"
    labels = {
      env     = "Production"
      Country = "India"
    }
  }
  wait_for_rollout = false

  spec {
    replicas = 2
    selector {
      match_labels = {
        pod     = "wp"
        env     = "Production"
        Country = "India"

      }
    }

    template {
      metadata {
        labels = {
          pod     = "wp"
          env     = "Production"
          Country = "India"
        }
      }

      spec {
        volume {
          name = "wp-vol"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.wp-pvc1.metadata.0.name
          }
        }

        container {
          image = "wordpress:4.8-apache"
          name  = "wp-container"
          env {
            name  = "WORDPRESS_DB_HOST"
            value = "${google_sql_database_instance.instance.public_ip_address}:3306"
          }
          env {
            name  = "WORDPRESS_DB_USER"
            value = "root"
          }
          env {
            name  = "WORDPRESS_DB_PASSWORD"
            value = var.sql_root_password
          }
          env {
            name  = "WORDPRESS_DB_NAME"
            value = google_sql_database.database.name
          }
          env {
            name  = "WORDPRESS_TABLE_PREFIX"
            value = "wp_"
          }
          volume_mount {
            name       = "wp-vol"
            mount_path = "/var/www/html/"
          }

          port {
            container_port = 80
          }
        }
      }
    }
  }
}


//Creating LoadBalancer Service for WordPress Pods
resource "kubernetes_service" "wpService" {
  metadata {
    name = "wp-svc"
    labels = {
      env     = "Production"
      Country = "India"
    }
  }

  depends_on = [
    kubernetes_deployment.wp-dep
  ]

  spec {
    type = "LoadBalancer"
    selector = {
      pod = "wp"
    }

    port {
      name = "wp-port"
      port = 80
    }
  }
}

//Wait For LoadBalancer to Register IPs
resource "time_sleep" "wait_60_seconds" {
  create_duration = "60s"
  depends_on      = [kubernetes_service.wpService]
}


