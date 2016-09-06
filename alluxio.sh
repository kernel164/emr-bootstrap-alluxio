#!/bin/bash

version=$1
[[ -z $version ]] && version=1.2.0

# prepare
sudo wget https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 -O /usr/local/bin/jq
sudo chmod 755 /usr/local/bin/jq

ismaster=`cat /mnt/var/lib/info/instance.json | jq -r '.isMaster'`
masterdns=`cat /mnt/var/lib/info/job-flow.json | jq -r '.masterPrivateDnsName'`

cd /opt

# Download alluxio
sudo wget http://alluxio.org/downloads/files/${version}/alluxio-${version}-bin.tar.gz
sudo tar -zxf alluxio-${version}-bin.tar.gz
sudo chown -R root:root alluxio-${version} 

# Download client
sudo wget http://downloads.alluxio.org/downloads/files/${version}/alluxio-core-client-spark-${version}-jar-with-dependencies.jar

cd alluxio-${version}

if [[ ${ismaster} == "true" ]]; then
  [[ ${masterdns} == "localhost" ]] && masterdns=`hostname -f`
  # bootstrap
  sudo ./bin/alluxio bootstrapConf ${masterdns}
  # Format
  sudo ./bin/alluxio format
  # Start master
  sudo ./bin/alluxio-start.sh master
else
  # bootstrap
  sudo ./bin/alluxio bootstrapConf ${masterdns}  
  # Start worker
  sudo ./bin/alluxio-start.sh worker Mount
fi
