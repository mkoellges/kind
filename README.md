# Kind

## Create kind cluster

```sh
kind create cluster \
    --name dev-1 \
    --image kindest/node:v1.28.0 \
    --config kind.yaml
```

You have different versions aviable like

- kindest/node:v1.26.6
- kindest/node:v1.27.3
- kindest/node:v1.28.0

You can check all available versions [here0](https://hub.docker.com/r/kindest/node/tags?page=1&name=27)

## Add loadbalancer capabilities

```sh
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.7/config/manifests/metallb-native.yaml
```

Wait until the MetalLB pods (controller and speakers) are ready:

```sh
kubectl wait --namespace metallb-system \
                --for=condition=ready pod \
                --selector=app=metallb \
                --timeout=90s
```

## Setup address pool used by loadbalancers

```sh
docker network inspect -f '{{.IPAM.Config}}' kind
```

Change the ip range in metallb.yaml and

```sh
kubectl apply -f metallb.yaml
```

## Install ArgoCD

To install ArgoCD follow the README.md from [here](https://github.com/mkoellges/argocd-demo)

## Bootstrap the new Cluster

To Bootstrap this new cluster using ArgoCD, clone [This Repo](https://github.com/mkoellges/argocd-ops).
