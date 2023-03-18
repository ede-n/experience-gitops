# experience-gitops

Repo to learn GitOps with various implementations - ArgoCD or FluxCD.

## 1. Create a local kubernetes cluster and install StorageClasses.

You may create a local cluster with either `Minikube` or `Colima`.

* Follow [this](./docs/local-k8s-cluster-with-minikube.md) document to create a local k8s cluster with minikube.
* Follow [this](./docs/local-k8s-cluster-with-colima.md) document to create a local k8s cluster with colima.

## 2. Install Argocd

See [GitOps with ArgoCD](docs/argocd-installation.md) to install Argocd.


## 3. Deploy local git server

You may either run a git server using [Git-Server](./docs/local-git-server.md) OR [Gitea](./docs/local-git-server-with-gitea.md) (Incomplete).


## Future work

1. Define and install PriorityClasses along with StorageClasses.