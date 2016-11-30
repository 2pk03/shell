#/bin/bash
service postgresql stop
service mysqld stop
service ambari-agent stop
service ambari-server stop

# kill ambari ping process
fuser -k 8670/tcp

# kill all running java processes
killall -9 java

#remove dfs data dir
rm -rf /hadoop

# reset psql and mysql
rm -rf /var/lib/mysql/* /var/lib/pgsql/*

#remove hdp packages
yum remove -y hdp-select* falcon_* atlas-metadata_* lucidworks-* bigtop-* extjs* spark* bigtop* slider* hue\* ambari\*  hadoop\* knox\* pig\* oozie\* zookeeper\* tez\* phoenix\*
hbase\* hive\* storm\* kafka\* ranger\* smartsense*  

echo "=> remove files and directories"
rm -rf /etc/hadoop /etc/falcon /etc/hive /etc/hbase /etc/oozie /etc/sqoop /etc/hue /etc/zookeeper /etc/flume /etc/storm* /etc/hive* \
/etc/tez /etc/knox /etc/kafka /etc/slider /etc/spark /etc/pig /etc/phoenix /etc/ranger* /etc/zeppelin /etc/atlas \
/var/run/hadoop* /var/run/hbase /var/run/hive* /var/run/oozie /var/run/sqoop /var/run/hue /var/run/zookeeper /var/run/flume \
/var/run/storm /var/run/falcon /var/run/webhcat /var/run/knox /var/run/kafka /var/run/spark /var/run/ranger /var/run/ambari* \
/var/run/atlas /var/log/hbase /var/log/hive* /var/log/oozie /var/log/sqoop /var/log/hue /var/log/zookeeper /var/log/flume \
/var/log/storm /var/log/falcon /var/log/webhcat /var/log/hadoop* /var/log/knox /var/log/kafka /var/log/spark /var/log/ranger \
/var/log/ambari* /var/log/atlas /var/log/zeppelin /usr/lib/flume /usr/lib/storm /var/lib/atlas /var/tmp/oozie /tmp/hive* \
/tmp/hadoop* /kafka-logs /var/lib/ambari-* /var/lib/flume /var/lib/oozie /var/lib/slider /var/lib/zeppelin /var/lib/ranger \
/var/lib/hive* /var/lib/knox /var/lib/hadoop-* /usr/lib/ambari-* /etc/ambari-* /etc/ams* /usr/hdp/current /tmp/ambari* \
/usr/hdp   

echo "=> remove HDP system user accounts"
cat >rmuser <<EOL
oozie
hive
ambari-qa
flume
hdfs
knox
storm
spark
mapred
hbase
tez
zookeeper
kafka
falcon
sqoop
yarn
hcat
ams
atlas
hue
zeppelin
kms
ranger
EOL

for i in $(cat rmuser); do userdel -rf $i;done

rm -f rmuser
echo "Ambari, HDP and dependencies removed"
