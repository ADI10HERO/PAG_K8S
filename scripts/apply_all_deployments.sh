for i in yamls/*-deployment.yaml; do kubectl apply -f $i; done
