# Deploy a local Git Server on Kubernetes

0. The following global variables are required to run commands from this document.

    ```
     export K8S_CONTEXT='<argocd-demo OR colima-argocd-demo>'
    ```

1. Deploy GitServer.

    ```
    kustomize build workload/git-server/base/ | kubectl apply -f - --context=${K8S_CONTEXT}
    ```

2. Export Git Server pod name 
   
    ```
    git_server_pod_name=$(kubectl get po -n git-server --context=${K8S_CONTEXT} -l app=git-server -oname | awk -F/ '{ print $2 }')
    ```

3. Clone the remote repo on git-server pod

    ```
    kubectl -n git-server exec "${git_server_pod_name}" --context=${K8S_CONTEXT} -- git clone --bare https://github.com/ede-n/experience-gitops.git
    ```

3. Validate the clone 

    ```
    kubectl -n git-server exec "${git_server_pod_name}" --context=${K8S_CONTEXT} -- ls -al /git/experience-gitops.git
    ```

4. Expose GitServer on k8s to your local by port forwarding

    ```
    kubectl -n git-server port-forward "${git_server_pod_name}" 9418 > /dev/null 2>&1 &
    ```

5. Clone the git repo locally and add git-server as its remote.

    ```
    mkdir -p ~/tmp
    cd ~/tmp
    git clone https://github.com/ede-n/experience-gitops.git
    git remote add git-server git://localhost/experience-gitops.git
    git push git-server master
    ```
