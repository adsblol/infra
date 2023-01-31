debug-vmagent:
	kubectl -n monitoring-system port-forward svc/vmagent-default 8429:8429
