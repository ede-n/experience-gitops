.PHONY: clean cluster.create cluster.bootstrap argocd.inital-admin-password

CLUSTER_NAME ?= 'argocd-demo'
K8S_CONTEXT ?= 'argocd-demo'
K8S_VERSION ?= '1.25.6'
ARGOCD_LOCAL_PORT ?= '8888'

export PROMPT_EOL_MARK := ''
clean:
	minikube delete -p $(CLUSTER_NAME)

cluster.create:
	minikube start -p $(CLUSTER_NAME) --memory 8192 --cpus 4 --kubernetes-version $(K8S_VERSION)

cluster.bootstrap: cluster.create
	kustomize build bootstrap-k8s/kube-system/base | kubectl apply -f - --context=$(K8S_CONTEXT)
	kustomize build bootstrap-k8s/argocd/base | kubectl apply -f - --context=$(K8S_CONTEXT)
	kubectl wait deployment -n argocd  argocd-server --for condition=Available=True --timeout=90s --context=$(K8S_CONTEXT)

argocd.local-port-forward:
	kubectl port-forward svc/argocd-server -n argocd $(ARGOCD_LOCAL_PORT):443 --context=$(K8S_CONTEXT) > /dev/null 2>&1 &

argocd.initial-admin-password:
	kubectl get secret/argocd-initial-admin-secret -n argocd -o yaml --context=$(K8S_CONTEXT) | yq .data.password | base64 -d

argocd.change-admin-password: argocd.local-port-forward
	argocd login 127.0.0.1:$(ARGOCD_LOCAL_PORT) --username=admin --insecure