#!/bin/bash

read -p "HOSTNAME:" HOSTNAME
read -p "DOMAIN:" DOMAIN
read -p "IP:" IP
read -p "NETMASK:" NETMASK
read -p "GATEWAY:" GATEWAY
read -p "DNSSERVER:" DNSSERVER

#hostname set + hosts fix
sudo hostnamectl hostname "${HOSTNAME}.${DOMAIN}"
sudo sed -i "/.*127.0.1.1.*/c\127.0.1.1\t${HOSTNAME}.${DOMAIN}\t${HOSTNAME}" /etc/hosts

#static ip
if grep -q "iface enp1s0 inet dhcp" /etc/network/interfaces; then
    sudo sed -i "/iface\senp1s0\sinet\sdhcp/c\iface enp1s0 inet static\n\taddress ${IP}\n\tnetmask ${NETMASK}\n\tgateway ${GATEWAY}" /etc/network/interfaces
fi

#ip on lockscreen
if ! grep -q "IP: \4" /etc/issue; then
    echo "IP: \4" | sudo tee -a /etc/issue &> /dev/null
fi

#default dns server
echo -e "nameserver ${DNSSERVER}" | sudo tee /etc/resolv.conf &> /dev/null

#shorten grub timeout
sudo sed -i "/.*GRUB_TIMEOUT=.*/c\GRUB_TIMEOUT=1" /etc/default/grub
sudo update-grub

#bind9 entry (copy paste)
echo -e "$(hostname --short)\tIN\tA\t${IP}"
