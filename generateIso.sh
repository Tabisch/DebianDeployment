#!/bin/bash

echo "Filename"
read filename

sudo rm ./${filename}.iso

cd custom_iso/

find -follow -type f ! -name md5sum.txt -print0 | xargs -0 md5sum > md5sum.txt

cd ~/

genisoimage -r -J -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o ${filename}.iso custom_iso

sudo cp ${filename}.iso /var/lib/libvirt/images/

sudo chown -R libvirt-qemu:libvirt-qemu /var/lib/libvirt/images/${filename}.iso
