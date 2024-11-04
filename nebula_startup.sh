#! /bin/bash
# # install nebula on a single machine
apt-get update \
&& apt-get install -y wget

wget https://oss-cdn.nebula-graph.io/package/3.8.0/nebula-graph-3.8.0.ubuntu1804.amd64.deb
dpkg -i nebula-graph-3.8.0.ubuntu1804.amd64.deb 
/usr/local/nebula/scripts/nebula.service start all
wget https://github.com/vesoft-inc/nebula-console/releases/download/v3.8.0/nebula-console-linux-amd64-v3.8.0
cp nebula-console-linux-amd64-v3.8.0 /usr/local/nebula/bin/nebula-console
chmod a+x /usr/local/nebula/bin/nebula-console
/usr/local/nebula/bin/nebula-console -u root -p nebula -port 9669 -addr 127.0.0.1 -e "ADD HOSTS 127.0.0.1:9779"