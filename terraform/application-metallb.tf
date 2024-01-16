resource "helm_release" "metallb" {
  depends_on       = [kind_cluster.default]
  name             = "metallb"
  namespace        = "metallb"
  create_namespace = true
  repository       = "https://metallb.github.io/metallb"
  chart            = "metallb"

  values = [
    "${file("./helm/metallb-values.yaml")}"
  ]
}

data "kubectl_file_documents" "metallb" {
  content = file("./manifests/metallb.yaml")
}

resource "kubectl_manifest" "deploy-metallb" {
  depends_on = [
    kind_cluster.default,
    helm_release.metallb
  ]

  for_each  = data.kubectl_file_documents.metallb.manifests
  yaml_body = each.value
}
