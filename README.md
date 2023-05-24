# Kind

## Create kind cluster

```sh
kind create cluster \
    --name monitoring \
    --image kindest/node:v1.25.3 \
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
