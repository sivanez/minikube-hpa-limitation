# Kubernetes Provider
provider "kubernetes" {
  config_path = "~/.kube/config" # Minikube configuration path
}

# Local Variables
locals {
  nginx_deployment_name  = "nginx-deployment"
  nginx_replicas         = 2
  nginx_image            = "nginx:latest"
  nginx_request_cpu      = "50m"
  nginx_request_memory   = "64Mi"
  nginx_limit_cpu        = "100m"
  nginx_limit_memory     = "128Mi"
  nginx_hpa_name         = "nginx-hpa"
  nginx_hpa_min_replicas = 1
  nginx_hpa_max_replicas = 10
  load_generator_name    = "cpu-load-generator"
}

# NGINX Deployment
resource "kubernetes_deployment" "nginx_deployment" {
  metadata {
    name      = local.nginx_deployment_name
    namespace = "default"
  }

  spec {
    replicas = local.nginx_replicas

    selector {
      match_labels = {
        app = "nginx"
      }
    }

    template {
      metadata {
        labels = {
          app = "nginx"
        }
      }

      spec {
        container {
          name  = "nginx"
          image = local.nginx_image

          resources {
            requests = {
              cpu    = local.nginx_request_cpu
              memory = local.nginx_request_memory
            }
            limits = {
              cpu    = local.nginx_limit_cpu
              memory = local.nginx_limit_memory
            }
          }
        }
      }
    }
  }
}

# Kubernetes Horizontal Pod Autoscaler
resource "kubernetes_horizontal_pod_autoscaler_v2" "nginx_hpa" {
  metadata {
    name      = local.nginx_hpa_name
    namespace = "default"
  }

  spec {
    scale_target_ref {
      api_version = "apps/v1"
      kind        = "Deployment"
      name        = local.nginx_deployment_name
    }

    min_replicas = local.nginx_hpa_min_replicas
    max_replicas = local.nginx_hpa_max_replicas

    metric {
      type = "Resource"
      resource {
        name  = "cpu"
        target {
          type               = "Utilization"
          average_utilization = 50
        }
      }
    }
  }
}

resource "kubernetes_job" "cpu_load_generator" {
  metadata {
    name      = "cpu-load-generator"
    namespace = "default"
  }

  spec {
    parallelism  = 2
    completions  = 4
    ttl_seconds_after_finished = 100 # Cleanup job 100 seconds after completion
    template {
      metadata {
        labels = {
          app = "cpu-load-generator"
        }
      }
      spec {
        restart_policy = "Never"
        container {
          name  = "cpu-load"
          image = "busybox"
          command = [
            "/bin/sh", "-c",
            "while true; do echo 'CPU load' > /dev/null; done"
          ]
          resources {
            requests = {
              cpu    = "100m"
              memory = "64Mi"
            }
          }
        }
      }
    }
  }
}

