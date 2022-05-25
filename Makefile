NAMESPACE=micropets-supplychain

namespace:
	kubectl create namespace $(NAMESPACE) --dry-run=client -o yaml | kubectl apply -f -
	kubectl get namespace $(NAMESPACE) 
	
kapp-deliverables: 
	ytt --ignore-unknown-comments  -f deliverables --data-values-env MICROPETS | kapp deploy --yes -c -a micropet-deliverables --into-ns $(NAMESPACE)  -f-

kapp-undeliverables: 
	kapp delete --yes -c -a micropet-deliverables 

	: 
	ytt --ignore-unknown-comments  -f deliverables --data-values-env MICROPETS | kubectl apply -n $(NAMESPACE) -f-

k-undeliverables: 
	ytt --ignore-unknown-comments  -f deliverables --data-values-env MICROPETS | kubectl delete -n $(NAMESPACE) -f-

