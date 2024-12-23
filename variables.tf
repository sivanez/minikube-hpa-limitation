variable "nginx_deployment_name" {
  description = "Name of the Nginx deployment"
  default     = "nginx-deployment"
}

variable "nginx_replicas" {
  description = "Number of replicas for Nginx deployment"
  default     = 5
}

variable "nginx_image" {
  description = "Image for the Nginx container"
  default     = "nginx:latest"
}

variable "nginx_request_cpu" {
  description = "CPU requests for Nginx container"
  default     = "100m"
}

variable "nginx_request_memory" {
  description = "Memory requests for Nginx container"
  default     = "128Mi"
}

variable "nginx_limit_cpu" {
  description = "CPU limits for Nginx container"
  default     = "200m"
}

variable "nginx_limit_memory" {
  description = "Memory limits for Nginx container"
  default     = "256Mi"
}

variable "nginx_hpa_name" {
  description = "Name of the HPA for Nginx"
  default     = "nginx-hpa"
}

variable "nginx_hpa_min_replicas" {
  description = "Minimum number of replicas for HPA"
  default     = 1
}

variable "nginx_hpa_max_replicas" {
  description = "Maximum number of replicas for HPA"
  default     = 10
}

variable "hpa_custom_metric_name" {
  description = "Custom metric name for HPA"
  default     = "http_requests_per_second"
}

variable "hpa_custom_metric_target_value" {
  description = "Target value for the custom metric"
  default     = "10"
}
