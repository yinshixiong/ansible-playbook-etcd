#!/bin/bash

yum clean all && yum repolist && yum makecache
yum -y localinstall ansible/rpms/*
yum -y install expect jq nc httpd-tools bash-com*
chmod +x expect.exp

# create private key
if [ ! -f /root/.ssh/id_rsa ];then
    ssh-keygen -t rsa -b 2048 -P "" -f /root/.ssh/id_rsa
fi

sed -i -r 's/(#)(forks          = )(5)/\220/g' /etc/ansible/ansible.cfg
cat host_ip.txt | while read ip user password; do
  echo -e "\e[1;35m开始同$ip免密认证\e[0m"
  ./expect.exp $ip $user $password
done
