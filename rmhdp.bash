#/bin/bash
/etc/init.d/postgresql stop
/etc/init.d/ambari-agent stop
/etc/init.d/ambari-server stop

# kill ambari ping process
fuser -k 8670/tcp

#remove hdp packages
yum remove hdp-select* falcon_* atlas-metadata_* lucidworks-* bigtop-* extjs* spark* bigtop* slider* postgres* hue\* ambari\*  hadoop\* knox\* pig\* oozie\* zookeeper\* tez\* phoenix\*
hbase\* hive\* storm\* kafka\* ranger\* -y

echo "=> remove files and directories"
rm -rf /etc/hadoop /etc/falcon /etc/hive /etc/hbase/ /etc/oozie /etc/sqoop /etc/hue /etc/zookeeper /etc/flume /etc/storm* /etc/hive* /etc/tez /etc/knox /etc/kafka /etc/slider /etc/spark /etc/pig /etc/phoenix /etc/ranger* /etc/zeppelin /etc/atlas /var/run/hadoop* /var/run/hbase /var/run/hive /var/run/oozie/ /var/run/sqoop/ /var/run/hue /var/run/zookeeper/ /var/run/flume/ /var/run/storm/ /var/run/falcon/ /var/run/webhcat/ /var/run/knox/ /var/run/kafka/ /var/run/spark/ /var/run/ranger/ /var/run/ambari* /var/run/atlas/ /var/log/hadoop /var/log/hbase/ /var/log/hive /var/log/oozie/ /var/log/sqoop/ /var/log/hue /var/log/zookeeper/ /var/log/flume/ /var/log/storm/ /var/log/hive-hcatalog/ /var/log/falcon/ /var/log/webhcat/ /var/log/hadoop* /var/log/knox/ /var/log/kafka/ /var/log/spark/ /var/log/ranger/ /var/log/ambari* /var/log/atlas/ /var/log/zeppelin/ /usr/lib/flume/ /usr/lib/storm/ /var/lib/atlas/ /var/tmp/oozie/ /tmp/hive/ /tmp/hadoop-hdfs/ /hadoop/oozie/ /hadoop/zookeeper/ /hadoop/hdfs/ /hadoop/storm/ /hadoop/falcon/ /hadoop/yarn/ /kafka-logs/ /var/lib/ambari-* /var/lib/flume/ /var/lib/oozie/ /var/lib/slider/ /var/lib/zeppelin/ /var/lib/ranger/ /var/lib/hive/ /var/lib/pgsql/ /var/lib/knox /var/lib/hadoop-* /usr/lib/ambari-* /etc/ambari-* /etc/ams*

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
