#!/bin/bash

# Use the following line if you booted the machine with a static IP
hostnamectl set-hostname ${hostname}
echo "127.0.0.1 ${hostname}" >>/etc/hosts
echo "${local_ip} ${hostname}" >>/etc/hosts
yum -y update
yum -y install wget
wget -O install_salt.sh https://bootstrap.saltstack.com
sh install_salt.sh
echo "file_client: local" >>/etc/salt/minion
echo "local: True" >>/etc/salt/minion
echo "fileserver_backend:" >>/etc/salt/minion
echo "  - roots" >>/etc/salt/minion
echo "  - git" >>/etc/salt/minion
echo "" >>/etc/salt/minion
echo "gitfs_remotes:" >>/etc/salt/minion
echo "  - https://github.com/jolson7168/sun-java-formula.git" >>/etc/salt/minion
echo "  - https://github.com/jolson7168/zookeeper-formula.git" >>/etc/salt/minion
service salt-minion stop
yum -y install -y git
yum -y install -y python-pygit2
mkdir /srv/salt
git clone https://github.com/jolson7168/kafka.git /home/centos/kafka
cp -R /home/centos/kafka/salt/* /srv/salt
salt-call --local state.highstate --state-verbose=False


