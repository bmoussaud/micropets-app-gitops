NAMESPACE=micropets-supplychain

namespace:
	kubectl create namespace $(NAMESPACE) --dry-run=client -o yaml | kubectl apply -f -
	kubectl get namespace $(NAMESPACE) 
	
.PHONY: deliverables
deliverables: 
	ytt --ignore-unknown-comments  -f deliverables --data-values-env MICROPETS | kapp deploy --yes -c -a micropet-deliverables --into-ns $(NAMESPACE)  -f-


