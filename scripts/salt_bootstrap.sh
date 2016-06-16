#!/bin/bash

# Use the following line if you booted the machine with a static IP
echo "127.0.0.1 ip-10-165-40-100" >>/etc/hosts
yum -y update
yum -y install wget
wget -O install_salt.sh https://bootstrap.saltstack.com
sh install_salt.sh
echo "file_client: local" >>/etc/salt/minion
echo "local: True" >>/etc/salt/minion
service salt-minion stop
yum -y install -y git
yum -y install -y python-pygit2
sudo mkdir /srv/salt
git clone https://github.com/jolson7168/kafka.git /home/centos/kafka
sudo cp -R /home/centos/kafka/salt/* /srv/salt
salt-call --local state.highstate --state-verbose=False
