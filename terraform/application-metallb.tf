provider "kubernetes" {
  config_path = kind_cluster.default.kubeconfig_path
}

data "http" "metallb_manifest" {
  url = "https://raw.githubusercontent.com/metallb/metallb/v0.14.7/config/manifests/metallb-native.yaml"
}

resource "null_resource" "metallb_install" {
  depends_on = [kind_cluster.default]

  provisioner "local-exec" {
    command = "kubectl apply -f ${data.http.metallb_manifest.url}"
  }
}

resource "null_resource" "metallb_config" {
  depends_on = [null_resource.metallb_install]

  provisioner "local-exec" {
    command = "kubectl apply -f ./manifests/metallb-configmap.yaml"
  }
}
