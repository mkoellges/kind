# Kind

## Preparation

Install the Kubernetes Cloud Provider for KIND - you need it for using Service Type Loadabalancer later.

```bash
brew install cloud-provider-kind
```

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

```

The cluster is now created and argoCD is deployed.

## Run the Cloud Provider for Kind

Open a separate window and run

```bash
sudo cloud-provider-kind
```

Do not close this window - the proxy you started is needed!



## Connect to argocd

Connect to argocd usiing

Username: `admin`

Password: The output of  ```kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d```

## Bootstrap the new Cluster

To Bootstrap this new cluster using ArgoCD, clone [This Repo](https://github.com/mkoellges/argocd-ops).
