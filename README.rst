=================
Metrics
=================
Table of Contents
=================
.. contents::
.. section-numbering::

Setup
=======

Prerequisites
-------------------------
- Require 3 VMs to setup K8s
- ``$ sudo yum install ansible``
- ``$ pip install openshift pyyaml kubernetes`` (required for ansible K8s module)
- Update IPs in all these files (if changed)
    - ``ansible/group_vars/all.yml``
    - ``ansible/hosts``

Setup Structure
---------------
.. image:: images/setup.png #todo

Installation - Client Side
-------------------------

Nodes
`````
- **Node1** = 10.10.120.21
- **Node4** = 10.10.120.24

How installation is done?
`````````````````````````
- collectd installation
   `Please follow this <https://comtronic.com.au/how-to-install-and-setup-collectd-on-centos7/>`_ 
- Make following lines are present in collectd.conf (usually found at /opt/collected/etc/)
  `
   <Plugin network>
     
     Server "10.10.120.211" "30826"
   </Plugin>
  `
- Restart the service
   ``sudo systemctl restart collectd``
   
   OR
   
   run : 
   
   ``cd /opt/collectd``
   
   # make changes
   
   ``sudo sbin/collectcd``

   *(make sure only one instance is running at a time)*

Installation - Server Side
-------------------------

Nodes
`````
Inside Jumphost - POD12
   - **VM1** = 10.10.120.211
   - **VM2** = 10.10.120.203
   - **VM3** = 10.10.120.204


How installation is done?
`````````````````````````
**Using Ansible:**
   - **K8s**
      - **Prometheus:** 2 independent deployments
      - **Alertmanager:** 2 independent deployments
      - **Grafana:** 1 Replica deployment
      - **cAdvisor:** 1 daemonset, i.e 3 replicas, one on each node
      - **collectd-exporter:** 1 Replica
      - **postgresql:** 1 statefulset with 3 replicas
   - **NFS Server:** at each VM to store grafana data at following path
      - ``/usr/share/grafana``

How to setup?
`````````````
- **To setup K8s cluster, EFK and PAG:** Run the ansible-playbook ``ansible/playbooks/setup.yaml``
- **To clean everything:** Run the ansible-playbook ``ansible/playbooks/clean.yaml``

Do we have HA?
````````````````
Yes

Configuration
=============

K8s
---
Path to all yamls (Server Side)
````````````````````````````````
``ansible/roles/monitoring/files/``

K8s namespace
`````````````
``monitoring``

Configuration
---------------------------

Serivces and Ports
``````````````````````````

Services and their ports are listed below, 
one can go to IP of any node on the following ports, 
service will correctly redirect you 


  ======================       =======
      Service                   Port
  ======================       ======= 
     Prometheus                 30900
     Prometheus1                30901
     Alertmanager               30930
     Alertmanager1              30931
     Grafana                    30000
     Collectd-exporter          30130
  ======================       =======

How to change Configuration?
------------------------------
- Ports, names of the containers, pretty much every configuration can be modified by changing the required values in the respective yaml files.
- For metrics, on the client's machine, edit the collectd's configuration file, and add required plugins. For more details refer `this <https://collectd.org/wiki/index.php/First_steps>`_

Data Management
================================

1. Where is the data stored now?
----------------------------------
  - Grafana login and user data ==> On nodes, using postgresql database, 1 copy on each node  
  - Grafana dashboards and other data ==> On master, at /usr/share/monitoring_data/grafana
  - Prometheus Data ==> On VM2 and VM3, at /usr/share/monitoring_data/prometheus 
  
  **Note: Promethei data also are independent of each other, a shared data solution gave errors**

2. Do we have backup of data?
-------------------------------
  Promethei even though independent scrape same targets, 
  have same alert rules, therefore generate very similar data.

  Grafana's postgres part of the data has 2 replicas
  Grafana's NFS part of the data has no backup
  
  
3. When containers are restarted, the data is still accessible?
-----------------------------------------------------------------
  Yes, unless the data directories are deleted (/usr/share/monitoring_data) from each node
