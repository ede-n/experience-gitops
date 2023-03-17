# experience-gitops

Repo to learn GitOps with various implementations.

## 1. Bootstrapping

1. Create a minikube k8s cluster

 Global variables

    ```
    export CLUSTER_NAME='argocd-demo'
    export K8S_CONTEXT='argocd-demo'
    export K8S_VERSION='1.25.6'
    ```

    Minikube

    ```
    minikube start -p ${CLUSTER_NAME} --memory 8192 --cpus 4 --kubernetes-version ${K8S_VERSION}
    ```

2. Bootstrap `kube-system` namespace

    ```
    kustomize build bootstrap-k8s/kube-system/base | kubectl apply -f - --context=${K8S_CONTEXT}
    ```

## 2. GitOps

### 2.1 GitOps with ArgoCD

See [GitOps with ArgoCD](docs/argocd-on-minikube.md)


## 3. Deploy local git server

Couple of options that we could try

### 1. Gitea (Incomplete TODO: update with working version)

Install Gitea on kubernetes.

```
helm repo add gitea-charts https://dl.gitea.io/charts/
helm install gitea gitea-charts/gitea
```

Access from local

```
minikube service gitea-http -p argocd-demo --url
```