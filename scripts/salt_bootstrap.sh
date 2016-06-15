#!/bin/bash

# Use the following line if you booted the machine with a static IP
echo "127.0.0.1 ip-10-165-40-100" >>/etc/hosts
wget -O install_salt.sh https://bootstrap.saltstack.com
sh install_salt.sh
echo "file_client: local" >>/etc/salt/minion
echo "local: True" >>/etc/salt/minion
service salt-minion stop
apt-get install -y git
mkdir /srv/salt
git clone https://github.com/jolson7168/kafka.git /home/ec2-user/kafka
cp -R /home/ec2-user/kafka/salt/* /srv/salt
salt-call --local state.highstate --state-verbose=False
