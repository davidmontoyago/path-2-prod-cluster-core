HELM_DEBUG=true
HELM=HELM_DEBUG=$(HELM_DEBUG) HELM_KUBECONTEXT=$(HELM_KUBECONTEXT) helm

helm:
	$(HELM) version
	$(HELM) env
	$(HELM) repo add stable https://kubernetes-charts.storage.googleapis.com/
	$(HELM) search repo stable

flux:
	$(HELM) repo add fluxcd https://charts.fluxcd.io
	kubectl apply -f https://raw.githubusercontent.com/fluxcd/helm-operator/master/deploy/flux-helm-release-crd.yaml
	kubectl create namespace flux --dry-run -o=yaml | kubectl apply -f -

core:
	make helm
	make flux