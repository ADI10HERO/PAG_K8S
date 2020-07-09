# create db things
k='kubectl -n monitoring'

$k apply -f volumes/db-pv.yaml
$k apply -f volumes/db-pvc.yaml

$k apply -f yamls/db-config.yaml
$k apply -f yamls/db-statefulset.yaml
$k apply -f yamls/db-service.yaml

# create grafana things
$k apply -f volumes/grafana-pv.yaml
$k apply -f volumes/grafana-pvc.yaml

$k apply -f yamls/grafana-datasource-config.yaml
$k apply -f yamls/grafana-deployment.yaml
$k apply -f yamls/grafana-service.yaml



