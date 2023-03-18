# GitOps with ArgoCD

## Installation of ArgoCd

0. The commands in this document require these global variables

    ```
    export K8S_CONTEXT='<argocd-demo OR colima-argocd-demo>'
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

