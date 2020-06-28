for i in yamls/*-config.yaml; do kubectl delete -f $i; done
