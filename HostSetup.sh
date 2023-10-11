#!/bin/bash

read -p "HOSTNAME:" HOSTNAME
read -p "DOMAIN:" DOMAIN
read -p "IP:" IP
read -p "NETMASK:" NETMASK
read -p "GATEWAY:" GATEWAY
read -p "DNSSERVER:" DNSSERVER

sudo hostnamectl hostname "${HOSTNAME}.${DOMAIN}"
sudo sed -i "/.*unassigned-hostname.*/c\127.0.1.1\t${HOSTNAME}.${DOMAIN}\t${HOSTNAME}" /etc/hosts

sudo sed -i "/.*enp1s0.*/c\iface enp1s0 inet static" /etc/network/interfaces
echo -e "\taddress ${IP}" | sudo tee -a /etc/network/interfaces
echo -e "\tnetmask ${NETMASK}" | sudo tee -a /etc/network/interfaces
echo -e "\tgateway ${GATEWAY}" | sudo tee -a /etc/network/interfaces

echo -e "${DNSSERVER}" | sudo tee /etc/resolve.conf
