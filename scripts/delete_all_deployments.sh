for i in yamls/*-deployment.yaml; do kubectl delete -f $i; done
