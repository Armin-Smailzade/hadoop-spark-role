export SPARK_HOME={{ spark.install_dir }}/spark-{{ spark.version }}-bin-hadoop{{ spark.hadoop_version }}

export PATH=$SPARK_HOME/bin:$SPARK_HOME/sbin:$PATH