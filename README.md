# PAG Stack no Kubernetes

## Prometheus, Alert Manager, Grafana (PAG) stack for dynamic monitoring deployed as a Kubernetes Cluster

* Prometheus is an open-source systems monitoring and alerting toolkit originally built at SoundCloud. Since its inception in 2012, many companies and organizations have adopted Prometheus, and the project has a very active developer and user community. It is now a standalone open source project and maintained independently of any company

* Alert-Manager handles alerts sent by client applications such as the Prometheus server. It takes care of deduplicating, grouping, and routing them to the correct receiver integration such as email, PagerDuty, or OpsGenie. It also takes care of silencing and inhibition of alerts.

* Grafana is a multi-platform open source analytics and interactive visualization web application. It provides charts, graphs, and alerts for the web when connected to supported data sources. It is expandable through a plug-in system. End users can create complex monitoring dashboards using interactive query builders.

## Why this Reposiotry?

- Did not find repositories with PAG stack deployment as a kubernetes cluster (not to monitor it but itself as a cluster)

# What will be deployed ?

**1.** Prometheus server scraping itself, cAdvisor and collectd-exporter

**2.** Alertmanager for alerting, using this is fairly simple. You can send Slack, IRC even Email notifications.

**3.** Grafana.

**4.** cAdvisor, this is used to monitor the docker-host, the machine on which all these containers will run.

**5.** Collectd exporter, not diving into architectural details, this is used to make collectd metrics available to prometheus

**6.** simple-webhook-reciever, this is a very simple http reciever ([written by me](https://hub.docker.com/r/adi10hero/simple-webhook-reciever)) to show the alerts on browser, as mentioned you can set up slack, email, etc but a simple webhook will give your alerts a platform without any external configurations, a good start, isn't it?

## How to run 

```sh
git clone https://github.com/ADI10HERO/PAG_K8S.git
cd PAG_K8S/
```

*Use nano / vim / any text editor you like and change the webhook address of webhook to `cluster-ip-of-webhook:5000/alerts` in `yamls/alertmanager-config.yaml`*
*Make similar appropritate changes in yamls/prometheus-config.yaml and yamls/grafana-datasources-config.yaml*
*In the grafana's config yaml **only line 17, url field will change** to the clusterIp of prometheus*

```sh
chmod +x make_all_executable.sh
./make_all_executable.sh

or 

chmod +x *.sh

./create_ns.sh #creates namespace, configs, deployments and services
kubectl get all -n monitoring # check all are up and healthy
```

### How to stop?
```sh
./delete_all.sh

## You can delete indiviually too as:
./delete_<what you want to delete>.sh
```


## Next steps
- [ ] Add basic auth to routes using caddy 
- [ ] Improving the gui and add features of [simple-webhook-reciever](https://github.com/adi10hero/simple-webhook-reciever/)
- [ ] Automate clusterIP address in yaml files

#### Contributing
- Fork the repository
- Add a feature
- Test it
- Make a PR, add test results in the PR
- Get it reviewed and merged :)


#### Note:
Any kind of contribution is most welcome

##### Refernces:
- [Setup prometheus in kubernetes](https://devopscube.com/setup-prometheus-monitoring-on-kubernetes/)
- [Setup alertmanager in kubernetes](https://devopscube.com/alert-manager-kubernetes-guide/)
- [Setup grafana in kubernetes](https://devopscube.com/setup-grafana-kubernetes/)