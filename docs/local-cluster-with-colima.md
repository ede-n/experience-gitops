# Local K8s cluster with Colima

1. Export global variables. You may get the version of kubernetes from [k3s Version](https://github.com/k3s-io/k3s/releases).

    ```
    export CLUSTER_NAME='argocd-demo'
    export K8S_CONTEXT='colima-argocd-demo'
    export K8S_VERSION='v1.25.7+k3s1'
    ```

2. Create a `Colima` cluster. 

    ```
    colima start --runtime containerd --kubernetes --cpu 4 --memory 8 --kubernetes-version ${K8S_VERSION} --profile ${CLUSTER_NAME}

3. Bootstrap `kube-system` namespace

    ```
    kustomize build bootstrap-k8s/kube-system/base | kubectl apply -f - --context=${K8S_CONTEXT}
    ```
