NAMESPACE=dev-tap

namespace:
	kubectl create namespace $(NAMESPACE) --dry-run=client -o yaml | kubectl apply -f -
	kubectl get namespace $(NAMESPACE) 
	
workloads:
	kapp deploy --into-ns dev-tap -c -a workloads -f <(ytt -f generators/workloads --data-value environment=azure/aks-eu-tap-2)

deploy-deliverables:
	kapp deploy -n dev-tap -c -a tap-config-extras -f environments/azure/aks-eu-tap-5

kapp-deliverables: namespace
	ytt --ignore-unknown-comments  -f deliverables --data-values-env MICROPETS | kapp deploy -y -c -a micropet-deliverables --into-ns $(NAMESPACE)  -f-

kapp-undeliverables: 
	kapp delete --yes -c -a micropet-deliverables 

gen-deliverables:
	ytt --ignore-unknown-comments  -f deliverables --data-values-env MICROPETS

store-deliverables:
	ytt --ignore-unknown-comments  -f deliverables --data-values-env MICROPETS > environments/$(MICROPETS_environment)/deliverables.yaml

k-undeliverables: 
	ytt --ignore-unknown-comments  -f deliverables --data-values-env MICROPETS | kubectl delete -n $(NAMESPACE) -f-

deploy-delivrables:
	kapp deploy -c -a tap-extra-config -f environments/azure/aks-eu-tap-5
