for i in yamls/*-service.yaml; do kubectl delete -f $i; done
