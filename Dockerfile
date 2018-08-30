FROM centos

RUN yum install java-1.8.0-openjdk-devel -y
ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.181-3.b13.el7_5.x86_64/
ENV PATH=$PATH:$JAVA_HOME/bin
RUN echo $(java -version)

RUN yum install wget -y
RUN wget http://apache.claz.org/hadoop/common/hadoop-3.1.1/hadoop-3.1.1.tar.gz
RUN tar xzf hadoop-3.1.1.tar.gz -C /opt
ENV HADOOP_HOME=/opt/hadoop-3.1.1 
ENV HADOOP_MAPRED_HOME=$HADOOP_HOME 
ENV HADOOP_COMMON_HOME=$HADOOP_HOME 
ENV HADOOP_HDFS_HOME=$HADOOP_HOME 
ENV HADOOP_HDFS_HOME=$HADOOP_HOME 
ENV YARN_HOME=$HADOOP_HOME 
ENV HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native 
ENV PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin

RUN echo export JAVA_HOME=$JAVA_HOME >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh

RUN sed -i 's/<configuration>/ /g' $HADOOP_HOME/etc/hadoop/core-site.xml
RUN sed -i 's/<\/configuration>/ /g' $HADOOP_HOME/etc/hadoop/core-site.xml
RUN echo '<configuration>' >> $HADOOP_HOME/etc/hadoop/core-site.xml
RUN echo '<property>' >> $HADOOP_HOME/etc/hadoop/core-site.xml
RUN echo '<name>fs.default.name</name>' >> $HADOOP_HOME/etc/hadoop/core-site.xml
RUN echo '<value>hdfs://localhost:9000</value>' >> $HADOOP_HOME/etc/hadoop/core-site.xml
RUN echo '</property>' >> $HADOOP_HOME/etc/hadoop/core-site.xml
RUN echo '</configuration>' >> $HADOOP_HOME/etc/hadoop/core-site.xml

RUN sed -i 's/<configuration>/ /g' $HADOOP_HOME/etc/hadoop/hdfs-site.xml
RUN sed -i 's/<\/configuration>/ /g' $HADOOP_HOME/etc/hadoop/hdfs-site.xml
RUN echo '<configuration>' >> $HADOOP_HOME/etc/hadoop/hdfs-site.xml
RUN echo '<property>' >> $HADOOP_HOME/etc/hadoop/hdfs-site.xml
RUN echo '<name>dfs.replication</name>' >> $HADOOP_HOME/etc/hadoop/hdfs-site.xml
RUN echo '<value>1</value>' >> $HADOOP_HOME/etc/hadoop/hdfs-site.xml
RUN echo '</property>' >> $HADOOP_HOME/etc/hadoop/hdfs-site.xml
RUN echo '<property>' >> $HADOOP_HOME/etc/hadoop/hdfs-site.xml
RUN echo '<name>dfs.name.dir</name>' >> $HADOOP_HOME/etc/hadoop/hdfs-site.xml
RUN echo '<value>file:///home/hadoop/hadoopinfra/hdfs/namenode</value>' >> $HADOOP_HOME/etc/hadoop/hdfs-site.xml
RUN echo '</property>' >> $HADOOP_HOME/etc/hadoop/hdfs-site.xml
RUN echo '<property>' >> $HADOOP_HOME/etc/hadoop/hdfs-site.xml
RUN echo '<name>dfs.data.dir</name>' >> $HADOOP_HOME/etc/hadoop/hdfs-site.xml
RUN echo '<value>file:///home/hadoop/hadoopinfra/hdfs/datanode</value>' >> $HADOOP_HOME/etc/hadoop/hdfs-site.xml
RUN echo '</property>' >> $HADOOP_HOME/etc/hadoop/hdfs-site.xml
RUN echo '</configuration>' >> $HADOOP_HOME/etc/hadoop/hdfs-site.xml

RUN sed -i 's/<configuration>/ /g' $HADOOP_HOME/etc/hadoop/yarn-site.xml
RUN sed -i 's/<\/configuration>/ /g' $HADOOP_HOME/etc/hadoop/yarn-site.xml
RUN echo '<configuration>' >> $HADOOP_HOME/etc/hadoop/yarn-site.xml
RUN echo '<property>' >> $HADOOP_HOME/etc/hadoop/yarn-site.xml
RUN echo '<name>yarn.nodemanager.aux-services</name>' >> $HADOOP_HOME/etc/hadoop/yarn-site.xml
RUN echo '<value>mapreduce_shuffle</value>' >> $HADOOP_HOME/etc/hadoop/yarn-site.xml
RUN echo '</property>' >> $HADOOP_HOME/etc/hadoop/yarn-site.xml
RUN echo '</configuration>' >> $HADOOP_HOME/etc/hadoop/yarn-site.xml

RUN sed -i 's/<configuration>/ /g' $HADOOP_HOME/etc/hadoop/mapred-site.xml
RUN sed -i 's/<\/configuration>/ /g' $HADOOP_HOME/etc/hadoop/mapred-site.xml
RUN echo '<configuration>' >> $HADOOP_HOME/etc/hadoop/mapred-site.xml
RUN echo '<property>' >> $HADOOP_HOME/etc/hadoop/mapred-site.xml
RUN echo '<name>mapreduce.framework.name</name>' >> $HADOOP_HOME/etc/hadoop/mapred-site.xml
RUN echo '<value>yarn</value>' >> $HADOOP_HOME/etc/hadoop/mapred-site.xml
RUN echo '</property>' >> $HADOOP_HOME/etc/hadoop/mapred-site.xml
RUN echo '</configuration>' >> $HADOOP_HOME/etc/hadoop/mapred-site.xml

RUN echo $(hadoop version)
# RUN hdfs namenode -format

RUN wget http://dk.mirrors.quenda.co/apache/sqoop/1.4.7/sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz
RUN tar -xvf sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz -C /opt
ENV SQOOP_HOME=/opt/sqoop-1.4.7.bin__hadoop-2.6.0 
ENV PATH=$PATH:$SQOOP_HOME/bin

ENV HADOOP_COMMON_HOME=$HADOOP_HOME 
ENV HADOOP_MAPRED_HOME=$HADOOP_HOME 

RUN $SQOOP_HOME/conf/sqoop-env-template.sh $SQOOP_HOME/conf/sqoop-env.sh