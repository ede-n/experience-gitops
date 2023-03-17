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