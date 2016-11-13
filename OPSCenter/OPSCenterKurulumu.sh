#OPSCenter KurulumuSH.

#Ilk olarak OPSCenter kurulumu  https://docs.datastax.com/en/opscenter/5.1/opsc/install/opscInstallDeb_t.html


echo "deb http://debian.datastax.com/community stable main" | sudo tee -a /etc/apt/sources.list.d/datastax.community.list
curl -L https://debian.datastax.com/debian/repo_key | sudo apt-key add -
sudo apt-get update
sudo apt-get install opscenter
sudo service opscenterd start

http://opscenter-host(PUPLIC DNS):8888/

#Daha sonra existing cluster ekle

Ekledikten sonra MultiNode için hata verebilir.

Node içi.
cd /var/lib/datastax-agent/conf/
sudo nano address.yaml


#ekle
stomp_interface: 172.31.16.101(OPS link)
use_ssl: 0
tmp_dir: /var/lib/datastax-agent/tmp/
backup_staging_dir: /var/lib/datastax-agent/clogs/
agent_rpc_interface: 172.31.47.38(her bir node linki)
jmx_port: 7199
#ekle

sudo service datastax-agent restart 



OPSCenter İçi:

Open opscenterd.conf and add the following:
[labs]
orbited_longpoll = true



sudo service opscenterd restart

Kontrol et.
