#!/bin/bash

sudo mkfs -t ext4 /dev/vdb

sudo blkid /dev/vdb

sudo mkdir /glusterfs

varUUID=$(sudo blkid /dev/vdb -s UUID -o value)

echo -e "UUID=${varUUID}\t/glusterfs\text4\tdefaults 0 0" | sudo tee -a /etc/fstab

sudo mount -a

sudo systemctl daemon-reload
