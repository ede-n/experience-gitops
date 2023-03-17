# experience-gitops

Repo to learn GitOps with various implementations.

## 1. Bootstrapping

You may create a local cluster with either `Minikube` or `Colima`.

* Follow [this](./docs/argocd-on-minikube.md) document for creating a local k8s cluster with minikube.
* Follow [this](./docs/argocd-on-colima.md) document for creating a local k8s cluster with colima.

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