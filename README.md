# Kind

## Create kind cluster

```sh
kind create cluster \
    --name monitoring \
    --image kindest/node:v1.26.3 \
    --config kind.yaml
```

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

## Setup address pool used by loadbalancers 🔗︎

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

Then run the command

```sh
kubectl apply -f .
```

Your Cluster is bootstrapped with all basic applications.