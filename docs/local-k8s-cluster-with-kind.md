# Local K8s cluster with Kind 

1. Export global variables

    ```
    export CLUSTER_NAME='argocd-demo'
    export K8S_CONTEXT='argocd-demo'
    export K8S_VERSION='1.25.6'
    ```

2. Create cluster with Kind

    Cluster config: One control plane node and two worker nodes.

    ```
    minikube start -p ${CLUSTER_NAME} --memory 8192 --cpus 4 --kubernetes-version ${K8S_VERSION}
    ```

3. Bootstrap `kube-system` namespace

    ```
    kustomize build bootstrap-k8s/kube-system/base | kubectl apply -f - --context=${K8S_CONTEXT}
    ```
