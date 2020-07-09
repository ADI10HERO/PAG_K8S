kubectl apply -f yamls/monitoring-namespace.yaml 

echo "applying all configs, deployments, svs in 5 secs, please press ctrl-C if this is not needed"

./apply_all_configs.sh
./apply_all_deployments.sh
./apply_all_services.sh

echo "Done :)"