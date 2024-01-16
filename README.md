# Kind

## Create kind cluster

Set the desired kubernetes version in `dev-1.tfvars` file

```yaml
...
kubernetes_version  = "kindest/node:v1.27.3"
...
```

You have different versions available like

- kindest/node:v1.26.6
- kindest/node:v1.27.3
- kindest/node:v1.28.0

You can check all available versions [here0](https://hub.docker.com/r/kindest/node/tags?page=1&name=27)

```sh
cd terraform
terraform init

terraform apply -var-file dev-1.tfvars

# Workaround: run it twice!
terraform apply -var-file dev-1.tfvars
```

Check the correct network ipAddress Settings in `./manifests/metallb.yaml` with

```bash
docker network inspect -f '{{.IPAM.Config}}' kind
```

Check the network CIDR range in `terraform/manifests/metallb.yaml` and change if needed the following setting:

```yaml
...
spec:
  addresses:
  - 172.18.0.200-172.18.0.250

...
```

## Bootstrap the new Cluster

To Bootstrap this new cluster using ArgoCD, clone [This Repo](https://github.com/mkoellges/argocd-ops).
