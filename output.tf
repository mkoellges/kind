output "cluster_name" {
  value     = var.cluster_name
  sensitive = false
}

output "kubernetes_version" {
  value     = var.kubernetes_version
  sensitive = false
}

output "kubeconfig_path" {
  value     = var.cluster_config_path
  sensitive = false
}
