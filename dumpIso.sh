#!/bin/bash

echo "Filename"
read filename

sudo rm -rf ~/custom_iso

sudo mkdir -p ~/custom_iso

sudo umount /mnt
sudo mount -t iso9660 -o loop ~/${filename}.iso /mnt/

cd /mnt

sudo tar cf - . | (cd ~/custom_iso; sudo tar xfp -)

cd ~/

sudo chmod -R 777 ~/custom_iso
