# delete existing
echo "Deleting configs, deployments and services"
./delete_all_configs.sh
./delete_all_deployments.sh
./delete_all_services.sh

# create / apply again
echo "Creating configs, deployments and services"
./apply_all_configs.sh
./apply_all_deployments.sh
./apply_all_services.sh

# Done
echo "Everything Done!"