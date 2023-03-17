# GitOps with ArgoCD

## Installation of ArgoCd

0. The commands in this document require these global variables

    ```
    export CLUSTER_NAME='<FILL IN>'
    export K8S_CONTEXT='<FILL IN>'
    ```

1. Install argocd (Non-HA install)

    ```
    kustomize build bootstrap-k8s/argocd/base | kubectl apply -f - --context=${K8S_CONTEXT}
    ```

2. Get argocd admin secret

    ```
    argocd_admin_passwd=$(kubectl get secret/argocd-initial-admin-secret --context=${K8S_CONTEXT} -n argocd -o yaml | yq .data.password | base64 -d)
    ```

3. Access argocd UI. In a separate shell window run 

    ```
     kubectl port-forward svc/argocd-server -n argocd --context=${K8S_CONTEXT} 8888:443 > /dev/null 2>&1 &
    ```

4. Change the admin password. Refer [doc](https://argo-cd.readthedocs.io/en/stable/user-guide/commands/argocd_account/).

    Login

    ```
    argocd login 127.0.0.1:8888 --username=admin --insecure
    ```

    Change password

    ```
    argocd account update-password --account admin --current-password ${argocd_admin_passwd} 
    ```

## Deploy a local git repo

### GitServer on k8s

    ```
    kustomize build workload/git-server/base/ | kubectl apply -f - --context=${K8S_CONTEXT}
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
    kubectl -n git-server port-forward "${git_server_pod_name}" 9418  &
    ```

Clone the git repo locally and add git-server as its remote.

    ```
    mkdir -p ~/tmp
    cd ~/tmp
    git clone https://github.com/ede-n/experience-gitops.git
    git remote add git-server git://localhost/experience-gitops.git
    git push git-server master
    ```
