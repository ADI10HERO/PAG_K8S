k='kubectl -n monitoring'


$k delete -f yamls/db-config.yaml
$k delete -f yamls/db-statefulset.yaml
$k delete -f yamls/db-service.yaml


$k delete -f yamls/grafana-datasource-config.yaml
$k delete -f yamls/grafana-deployment.yaml
$k delete -f yamls/grafana-service.yaml


$k delete -f volumes/grafana-pvc.yaml
$k delete -f volumes/grafana-pv.yaml


$k delete -f volumes/db-pvc.yaml
$k delete -f volumes/db-pv.yaml


