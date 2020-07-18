echo "If the monitoring part of ansible playbook ran successfully"
echo "Make changes to the following files in the lmaa/ansible/roles/monitoring/files directory"
echo "============================================================================================"
echo "============================================================================================"
echo "     File                                     Change        "
echo "grafana-deployment.yaml          Value of GF_DATABASE_HOST to clusterIP of postgresql" 
echo "alertmanager-deployment.yaml     cluster.peer to clusterIP of alertmanager1-service" 
echo "alertmanager1-deployment.yaml    cluster.peer to clusterIP of alertmanager-service" 
echo "prometheus-config.yaml           Replace Target Ips to respective clusterIPs of alertmanagers, cadvisor, collectd-exporter" 
echo "prometheus1-config.yaml           Replace Target Ips to respective clusterIPs of alertmanagers, cadvisor, collectd-exporter" 

read -p "Did you make the above changes? " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

echo "Appling your changes...."

k='kubectl -n monitoring'

pwd

$k apply -f ../ansible/roles/monitoring/files/grafana-deployment.yaml
$k apply -f ../ansible/roles/monitoring/files/alertmanager-deployment.yaml
$k apply -f ../ansible/roles/monitoring/files/alertmanager1-deployment.yaml

$k delete -f ../ansible/roles/monitoring/files/prometheus-deployment.yaml 
$k delete -f ../ansible/roles/monitoring/files/prometheus1-deployment.yaml

$k apply -f ../ansible/roles/monitoring/files/prometheus-config.yaml 
$k apply -f ../ansible/roles/monitoring/files/prometheus1-config.yaml 

$k apply -f ../ansible/roles/monitoring/files/prometheus-deployment.yaml 
$k apply -f ../ansible/roles/monitoring/files/prometheus1-deployment.yaml

$k get pods -o wide

echo "done"
