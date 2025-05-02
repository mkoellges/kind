provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }

}

resource "helm_release" "argocd" {
  depends_on       = [kind_cluster.default]
  name             = "argocd"
  namespace        = "argocd"
  create_namespace = true
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "7.9.0"

  values = [
    "${file("./helm/argocd-values.yaml")}"
  ]
}
