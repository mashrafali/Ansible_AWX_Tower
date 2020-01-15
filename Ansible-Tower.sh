#! /bin/bash

## THIS IS FOR RHEL

yum install git python python3 python-devel rh-python36-python-pip openssl ansible curl wget -y
pip3 install --upgrade pip
curl -k -O https://releases.ansible.com/ansible-tower/setup/ansible-tower-setup-latest.tar.gz
tar xvf ansible-tower-setup-latest.tar.gz
cd ansible-tower-setup-*
sed -i "s#admin_password=''#admin_password='equiinfra'#g" inventory
sed -i "s#pg_password=''#pg_password='equiinfra'#g" inventory
sed -i "s#rabbitmq_password=''#rabbitmq_password='equiinfra'#g" inventory
./setup.sh

##### Example playbook

--- # upgrade test

- hosts: all
  remote_user: root
  connection: ssh
  gather_facts: yes
  serial: 50                     ## Number of parallel hosts able to run

  tasks:
  - name: Package Upgrade
    yum:
      name: "*"
      update_cache: yes
      state: latest
    register: result
    notify:
    - Rebooting
  - debug : var=result

  handlers:
  - name: Rebooting
    command: /sbin/reboot