Works Well:

Ubuntu 14.04
Java 8

sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-set-default

#java -version


echo "deb http://www.apache.org/dist/cassandra/debian 22x main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list
echo "deb-src http://www.apache.org/dist/cassandra/debian 22x main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list

gpg --keyserver pgp.mit.edu --recv-keys F758CE318D77295D
gpg --export --armor F758CE318D77295D | sudo apt-key add -

gpg --keyserver pgp.mit.edu --recv-keys 2B5C1B00
gpg --export --armor 2B5C1B00 | sudo apt-key add -


gpg --keyserver pgp.mit.edu --recv-keys 0353B12C
gpg --export --armor 0353B12C | sudo apt-key add -

sudo apt-get update
sudo apt-get install cassandra


sudo service cassandra status
## Cassandra is running


sudo nodetool status

Datacenter: datacenter1
=======================
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address    Load       Tokens       Owns (effective)  Host ID                               Rack
UN  127.0.0.1  97.17 KB   256          100.0%            0497cf1e-9001-4201-ac15-420ed6c65626  rack1




#2 Node.
sudo service cassandra stop

sudo rm -rf /var/lib/cassandra/data/system/*

-*
sudo nano /etc/cassandra/cassandra.yaml
#En üste ekle
auto_bootstrap: false
#Değiştir


cluster_name: 'CassandraDOCluster'

. . .

seed_provider:
  - class_name: org.apache.cassandra.locator.SimpleSeedProvider
    parameters:
         - seeds: "your_server_ip,your_server_ip_2,...your_server_ip_n"

. . .

listen_address: your_server_ip

. . .

rpc_address: your_server_ip

. . .

endpoint_snitch: GossipingPropertyFileSnitch


-*
sudo apt-get install iptables-persistent

ls /etc/iptables
#rules.v4  rules.v6

sudo vi /etc/iptables/rules.v4
*filter
:INPUT ACCEPT [0:0]
-A INPUT -p tcp -s 172.31.40.221 -m multiport --dports 7000,9042 -m state --state NEW,ESTABLISHED -j ACCEPT
-A INPUT -p tcp -s 172.31.40.220 -m multiport --dports 7000,9042 -m state --state NEW,ESTABLISHED -j ACCEPT



-A INPUT -p tcp -s 172.31.40.222 -m multiport --dports 7000,9042 -m state --state NEW,ESTABLISHED -j ACCEPT
-A INPUT -p tcp -s 172.31.40.220 -m multiport --dports 7000,9042 -m state --state NEW,ESTABLISHED -j ACCEPT


sudo service iptables-persistent restart

sudo service cassandra start
sudo nodetool status
#Hata alabilirsin.



sudo vi /etc/cassandra/cassandra-env.sh
-*
JVM_OPTS=$JVM_OPTS -Djava.rmi.server.hostname=your ip

sudo service cassandra restart
sudo service cassandra start
sudo service cassandra status

sudo nodetool  status

|/ State=Normal/Leaving/Joining/Moving
--  Address       Load       Tokens       Owns (effective)  Host ID                               Rack
UN  172.31.4.123  140.02 KB  256          100.0%            fc9730f3-fa81-4cf8-be4e-d64e5629a2c8  rack1
UN  172.31.4.122  139.99 KB  256          100.0%            58c3026c-5c78-490a-9e1f-4f64ffe0f629  rack1


#Note
Cassandra node için cassandra.yaml değiştirmek için
sudo service cassandra stop

Değiştirdikten sonra
sudo service cassandra start

Bekle 5 dk olmazsa sunucu restart et

Oda olmazsa 
sudo service cassandra restart çektim node 1

2 dk sonra geldi
#cqlsh 172.31.4.123



#Spark Kurulum

sudo apt-add-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java7-installer


wget http://www.scala-lang.org/files/archive/scala-2.11.8.tgz
sudo mkdir /usr/local/src/scala


sudo tar xvf scala-2.11.8.tgz -C /usr/local/src/scala/
vi .bashrc
//inside
export SCALA_HOME=/usr/local/src/scala/scala-2.11.8
export PATH=$SCALA_HOME/bin:$PATH
//

. .bashrc

//scala -version

sudo apt-get install git


wget http://d3kbcqa49mib13.cloudfront.net/spark-2.0.0.tgz

tar xvf spark-2.0.0.tgz 

cd spark-2.0.0/

sbt package
sudo sbt assembly/
#hata verir üstteki

#normal python ile spark çalıştırma(.bashrc içine at)
export SPARK_HOME=/home/beyhan/spark-2.0.0
export PYTHONPATH=$SPARK_HOME/python/:$PYTHONPATH
PYTHONPATH=$SPARK_HOME/python/lib/py4j-0.10.1-src.zip:$PYTHONPATH
export PYTHONPATH=$SPARK_HOME/python:$SPARK_HOME/python/build:$PYTHONPATH
#bu islemden sonra python ile spark kodları çalıştırılırW.Setcluster istediğini seç.bir farkı yok.hemde cron joblı



export SPARK_HOME=/home/ubuntu/spark-2.0.0
export PYTHONPATH=$SPARK_HOME/python/:$PYTHONPATH
PYTHONPATH=$SPARK_HOME/python/lib/py4j-0.10.1-src.zip:$PYTHONPATH
export PYTHONPATH=$SPARK_HOME/python:$SPARK_HOME/python/build:$PYTHONPATH









