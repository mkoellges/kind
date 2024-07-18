provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }

}

resource "helm_release" "argocd" {
  depends_on       = [null_resource.metallb_config]
  name             = "argocd"
  namespace        = "argocd"
  create_namespace = true
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "5.52.0"

  values = [
    "${file("./helm/argocd-values.yaml")}"
  ]
}
