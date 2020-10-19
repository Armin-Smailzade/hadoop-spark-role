export HADOOP_HOME={{hadoop_install_path}}/hadoop-{{hadoop_version}}
export PATH=$HADOOP_HOME/sbin:$HADOOP_HOME/bin:$PATH

export HIVE_HOME={{hive_path}}/apache-hive-{{hive_version}}-bin
export PATH=$HIVE_HOME/bin:$PATH
export CLASSPATH=$CLASSPATH.:$HIVE_HOME/lib
export HIVE_CONF_DIR={{ hive_path }}/apache-hive-{{ hive_version}}-bin/conf
