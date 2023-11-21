provider "kubectl" {
  load_config_file       = false
  client_key             = base64decode(kind_cluster.default.cluster.client_key)
  cluster_ca_certificate = base64decode(kind_cluster.default.cluster_ca_certificate)
  client_certificate     = base64decode(kind_cluster.default.client_certificate)
}

data "kubectl_path_documents" "docs" {
  pattern = "./manifests/*.yaml"
}

resource "kubectl_manifest" "test" {
  for_each  = toset(data.kubectl_path_documents.docs.documents)
  yaml_body = each.value
}
