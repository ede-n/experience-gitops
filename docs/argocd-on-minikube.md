# GitOps with ArgoCD

## Installation of ArgoCd

1. Create minikube cluster and install argocd (Non-HA install)

    Global variables

    ```
    export CLUSTER_NAME='argocd-demo'
    export K8S_VERSION='1.25.6'
    export K8S_CONTEXT='argocd-demo'
    ```

    Minikube

    ```
    minikube start -p $(CLUSTER_NAME) --memory 8192 --cpus 4 --kubernetes-version $(K8S_VERSION)
    ```

    ArgoCD

    ```
    kustomize build workload/argocd/base | kubectl apply -f - --context=${K8S_CONTEXT}
    ```

2. Get argocd admin secret

    ```
    argocd_admin_passwd=$(kubectl get secret/argocd-initial-admin-secret -n argocd -o yaml | yq .data.password | base64 -d)
    ```

3. Access argocd UI

    ```
    minikube service argocd-server -p ${CLUSTER_NAME} --url -n argocd
    ```

4. Change the admin password. Refer [doc](https://argo-cd.readthedocs.io/en/stable/user-guide/commands/argocd_account/).

    ```
    # Get the host:port from the output of minikube command above
    argocd login 127.0.0.1:56010 --username=admin --insecure
    argocd account update-password --account admin --current-password ${argocd_admin_passwd} 
    ```

## Deploy a local git repo

### GitServer on k8s

    ```
    kustomize build workload/git-server/base/ | kubectl apply -f -
    ```

Clone the remote repo on git-server pod

    ```
    git_server_pod_name=$(kubectl get po -n git-server -l app=git-server -oname | awk -F/ '{ print $2 }')
    kubectl -n git-server exec "${git_server_pod_name}" -- git clone --bare https://github.com/ede-n/experience-gitops.git
    ```

Validate the clone 

    ```
    kubectl -n git-server exec "${git_server_pod_name}" -- ls -al /git/experience-gitops.git
    ```

In a new shell tab run 

    ```
    git_server_pod_name=$(kubectl get po -n git-server -l app=git-server -oname | awk -F/ '{ print $2 }')
    kubectl -n scm port-forward "${git_server_pod_name}" 9418  &
    ```

Clone the git repo locally and add git-server as its remote.

    ```
    git clone https://github.com/ede-n/experience-gitops.git
    git remote add git-server git://localhost/experience-gitops.git
    ```
