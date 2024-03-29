#!/bin/bash

sudo swapoff -a
sudo sed -i "/.*swap.*/d" /etc/fstab

if ! grep -q "br_netfilter" /etc/issue; then
    echo br_netfilter | sudo tee -a /etc/modules  &> /dev/null
fi

sudo modprobe br_netfilter
sudo sed -i "/.*net.ipv4.ip_forward.*/c\net.ipv4.ip_forward=1" /etc/sysctl.conf
sudo sysctl net.ipv4.ip_forward=1

sudo apt-get update

sudo apt-get install -y apt-transport-https ca-certificates curl gpg

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl containerd
sudo apt-mark hold kubelet kubeadm kubectl containerd
