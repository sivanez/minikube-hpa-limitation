output "nginx_deployment_name" {
  description = "The name of the Nginx deployment"
  value       = var.nginx_deployment_name
}

output "nginx_replicas" {
  description = "The number of replicas for the Nginx deployment"
  value       = var.nginx_replicas
}

output "hpa_name" {
  description = "The name of the Horizontal Pod Autoscaler for Nginx"
  value       = var.nginx_hpa_name
}

output "hpa_min_replicas" {
  description = "The minimum number of replicas for the HPA"
  value       = var.nginx_hpa_min_replicas
}

output "hpa_max_replicas" {
  description = "The maximum number of replicas for the HPA"
  value       = var.nginx_hpa_max_replicas
}

output "custom_metric_name" {
  description = "The name of the custom metric for the HPA"
  value       = var.hpa_custom_metric_name
}

output "custom_metric_target_value" {
  description = "The target value for the custom metric"
  value       = var.hpa_custom_metric_target_value
}
