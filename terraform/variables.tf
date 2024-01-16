variable "cluster_name" {
  type        = string
  description = "The name of the cluster."
}

variable "kubernetes_config_file" {
  type    = string
  default = "~/.kube/config"
}

variable "kubernetes_version" {
  type = string
}

variable "cluster_config_path" {
  type        = string
  description = "Cluster's kubeconfig location"
  default     = "~/.kube/config"
}

variable "argocd_version" {
  type        = string
  description = "Helm Chart version of argoCD"
}
