for i in yamls/*-service.yaml; do kubectl apply -f $i; done
