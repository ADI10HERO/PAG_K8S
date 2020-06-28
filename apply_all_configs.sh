for i in yamls/*-config.yaml; do kubectl apply -f $i; done
