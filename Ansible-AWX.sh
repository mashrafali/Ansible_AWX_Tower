#! /bin/bash

## FOR RHEL7
# https://gist.github.com/davivcgarcia/86bb4746c430ec719235217daf8198d8

## FOR CENTOS7
# https://ahmermansoor.blogspot.com/2019/09/install-ansible-awx-with-docker-compose-on-centos-7.html

yum upgrade -y && yum update -y && yum autoremove -y
yum-config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
yum install epel-release -y
yum install net-tools yum-utils htop -y
yum install git gcc gcc-c++ nodejs gettext device-mapper-persistent-data lvm2 bzip2 python-pip -y
yum install ansible -y
yum install docker-ce -y
systemctl enable docker
systemctl start docker
pip install --upgrade pip
pip install docker-compose
cd /root/
git clone --depth 50 https://github.com/ansible/awx.git
cd awx/installer
sed -i 's|admin_password=.*|admin_password=equiinfra|g' inventory
grep -v '^#' inventory | grep -v '^$'

ansible-playbook -i inventory install.yml