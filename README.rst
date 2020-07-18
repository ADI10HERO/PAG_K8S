Metrics
====================

A. Installation
===================

1. How is the installation done? 
--------------------------------
- A VM was created, and docker, docker-compose, pip, python, were installed using yum package manager (latest stable version)

- Created Prometheus, Alertmanager, Grafana, containers are deployed using docker-compose
 
- Collectd-Exporter, cAdvisor and a simple webhook receiver to receive alerts are also included in the compose file. The file and detailed explanation can be found `here <https://github.com/ADI10HERO/PAG_stack>`_

- Collectds running on Node4 and Node1 of Pod12, were configured to send metrics using binary network plugin of collectd, to the collectd-exporter container on the VM. 

 
2. What are the prerequisites?
-------------------------------
- How to read yaml 
- Knowledge about docker, docker-compose
- Configuration familiarity for:

 1. Prometheus

 2. Alertmanager

 3. Collectd (on the machine which is to be monitored)

- Some familiarity with PromQL (Prometheus Query Language) 


3. How to build the containers.
--------------------------------
- On the VM
    1. cd PAG_stack
    
    2. docker-compose up -d

    3. docker container ls
       
       You should see all 6 containers UP and cadvisor healthy
- On the machines which need to be monitored
    Check if collectd is configured correctly, this can be done by checking if following lines are there in the collectd.conf file and the daemon is running
    
        LoadPlugin network
        
        <Plugin network>
        
        Server "prometheus.example.com" "25826"
        
        </Plugin>
           


4. Do we have HA?
--------------------------------
- Prometheus by default doesn't have HA
 


5. If not, Can we achieve it easily ? Can we use both VMs to achieve HA?
-----------------------------------------------------------------------------
- Yes and yes!
- A simple method is to keep 2 instances of the same stack, scraping same servers, raising same alerts
- `More on prometheus being HA <https://prometheus.io/docs/introduction/faq/#can-prometheus-be-made-highly-available>`_


6. Elasticsearch support HA, does Prometheus?
----------------------------------------------------------------
- Nativelty doesn't, but it is configured to do so.


7. Can we have one more VM to have a complete 3-Node HA solution  
---------------------------------------------------------------------
- Done



B. Configuration
===================

1. What are all the configurations the user should know?
--------------------------------------------------
- IP of the VM : 10.10.120.202
 
  
  ====================       =======
   Service                                        Port
  ====================       =======
   Prometheus                               9090
   Alertmanager                             9093
   Grafana                                      3000
   Collectd-exporter                        9130
   cAdvisor                                     8080
   webhook receiver                      5000
  ====================       =======

-  All configurations, including the docker-compose.yml file is in the PAG_stack folder
-  Prometheus and alertmanager have their respective configuration (yaml) files in their respective folders in the PAG_stack folder
- On the client machines, collectd is generally installed in '/opt/collectd/' if its CentOs / RHEL machine, and the configuration can be found at '/opt/collectd/etc/collectd.conf'
- Grafana folder has pre-made dashboard Json files, which can be imported directly in grafana.
- Password and username to the grafana panel is written in the "config" file in the PAG_stack folder.


2. How to modify configurations?
----------------------------------
- Ports and names of the containers can be modified by changing the required values in the docker-compose.yml file.
- All other container configurations can be changed by editing their respective yaml files mentioned above on the VM
- For metrics, on the client's machine, edit the collectd's configuration file, and add required plugins. For more details refer `this <https://collectd.org/wiki/index.php/First_steps>`_



C. Data Management
====================

1. Where is the data stored now?
----------------------------------
  Docker volume, specified in the compose file

2. Do we have backup of data?
-------------------------------
  No

3. When containers are restarted, the data is still accessible?
-----------------------------------------------------------------
  Yes, unless the volumes are explicitly deleted.
