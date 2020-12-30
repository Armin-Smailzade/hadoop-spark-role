export HADOOP_HOME={{hadoop_install_path}}/hadoop-{{hadoop_version}}
export PATH=$HADOOP_HOME/sbin:$HADOOP_HOME/bin:$PATH
export HADOOP_LOG_DIR={{ hadoop_log_path }}
export YARN_LOG_DIR=$HADOOP_LOG_DIR

export HADOOP_PID_DIR={{hadoop_pid_path}}
export HADOOP_SECURE_DN_PID_DIR={{hadoop_pid_path}}

jdk_version=$(ls -al {{jvm_home}}|grep "^d"|grep "java"|awk '{print$NF}')
export JAVA_HOME={{ jvm_home }}/$jdk_version

export HADOOP_CLASSPATH=${JAVA_HOME}/lib/tools.jar
