# Hadoop-spark-ansible
- Install Hadoop cluster with ansible.
- JDK is  Openjdk-1.8.
- Hadoop version 2.7.2.
- Spark version 2.4.7.
- Hive is the version 2.3.7.
- Postgres database.

## Before Install
Update /hosts/host file.

## Install Hadoop
1. Download Hadoop to any path
2. Update the {{ download_path }} in vars/var_hadoop.yml & var_spark.yml & var_hive.yml
3. Use ansible template to generate the hadoop configration, so If your want to add more properties, just update the vars/var_hadoop.yml

---
### Install Hadoop Master

run shell like

```
ansible-playbook -i hosts/host master.yml
```

### Install Hadoop Workers

run shell like:
```
master_ip:  your hadoop master ip
master_hostname: your hadoop master hostname

above two variables must be same like your real hadoop master

ansible-playbook -i hosts/host workers.yml -e "master_ip=172.16.251.70 master_hostname=hadoop-master"

```

### Install Spark Master
run shell like:
```
ansible-playbook -i hosts/host spark.yml
```

### Install Spark Workers
run shell like:
```
ansible-playbook -i hosts/host spark_workers.yml
```

### Install hive
run shell like:
```
ansible-playbook -i hosts/host postgres.yml
```

### Install hive
1. **Create postgres database first and give right authority**
2. check vars/var_hive.yml
```
---

# hive basic vars
download_path: "/home/pippo/Downloads"                                 # your download path
hive_version: "2.3.2"                                                  # your hive version
hive_path: "/home/hadoop"
hive_config_path: "/home/hadoop/apache-hive-{{hive_version}}-bin/conf"
hive_tmp: "/home/hadoop/hive/tmp"                                      # your hive tmp path

hive_create_path:
  - "{{ hive_tmp }}"

hive_warehouse: "/user/hive/warehouse"                                # your hdfs path
hive_scratchdir: "/user/hive/tmp"
hive_querylog_location: "/user/hive/log"

hive_hdfs_path: 
  - "{{ hive_warehouse }}"
  - "{{ hive_scratchdir }}"
  - "{{ hive_querylog_location }}"

hive_logging_operation_log_location: "{{ hive_tmp }}/{{ user }}/operation_logs"

# database
db_type: "postgres"                                              # use your db_type, default is postgres
hive_connection_driver_name: "org.postgresql.Driver"
hive_connection_host: "172.16.251.33"
hive_connection_port: "5432"
hive_connection_dbname: "hive"
hive_connection_user_name: "hive_user"
hive_connection_password: "nfsetso12fdds9s"
hive_connection_url: "jdbc:postgresql://{{ hive_connection_host }}:{{ hive_connection_port }}/{{hive_connection_dbname}}?ssl=false"
# hive configration                                             # your hive site properties
hive_site_properties:
  - {
      "name":"hive.metastore.warehouse.dir",
      "value":"hdfs://{{ master_hostname }}:{{ hdfs_port }}{{ hive_warehouse }}"
  }
  - {
      "name":"hive.exec.scratchdir",
      "value":"{{ hive_scratchdir }}"
  }
  - {
      "name":"hive.querylog.location",
      "value":"{{ hive_querylog_location }}/hadoop"
  }
  - {
      "name":"javax.jdo.option.ConnectionURL",
      "value":"{{ hive_connection_url }}"
  }
  - {
    "name":"javax.jdo.option.ConnectionDriverName",
    "value":"{{ hive_connection_driver_name }}"
  }
  - {
    "name":"javax.jdo.option.ConnectionUserName",
    "value":"{{ hive_connection_user_name }}"
  }
  - {
    "name":"javax.jdo.option.ConnectionPassword",
    "value":"{{ hive_connection_password }}"
  }
  - {
    "name":"hive.server2.logging.operation.log.location",
    "value":"{{ hive_logging_operation_log_location }}"
  }

hive_server_port: 10000                                    # hive port
hive_hwi_port: 9999
hive_metastore_port: 9083

firewall_ports:
  - "{{ hive_server_port }}"
  - "{{ hive_hwi_port }}"
  - "{{ hive_metastore_port }}"
```

3. check hive.yml

```
- hosts: hive                   # in hosts/host
  remote_user: root
  vars_files:
   - vars/user.yml
   - vars/var_basic.yml
   - vars/var_master.yml
   - vars/var_hive.yml            # var_hive.yml
  vars:
     open_firewall: true           
     install_hive: true           
     config_hive: true
     init_hive: true               # init hive database after install and config
  roles:
    - hive

```
4. run it

```
ansible-playbook -i hosts/host hive.yml

```
