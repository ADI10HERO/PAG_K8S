# delete existing
echo "Deleting configs, deployments and services"
./delete_all_configs.sh
./delete_all_deployments.sh
./delete_all_services.sh

# Done
echo "Everything Done!"