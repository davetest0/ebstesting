   create_raid.sh
   sudo mdadm --create --verbose /dev/md0 --level=0 --name=MY_RAID --raid-devices=4 /dev/xvdj /dev/xvdk /dev/xvdl /dev/xvdm
   echo "now check for init and sync"
   sudo cat /proc/mdstat
   echo "look at the details of the raid with madam"
   sudo mdadm --detail /dev/md0
   echo "now lets make our FS"
   sudo mkfs.xfs -L MY_RAID /dev/md0
   echo "now make a /etc/mdadm.conf file"
   sudo mdadm --detail --scan | sudo tee -a /etc/mdadm.conf
   echo "now create a new ram disk image that incluces this raid"
   sudo dracut -H -f /boot/initramfs-$(uname -r).img $(uname -r)
   echo "create a mount point"
   sudo mkdir -p /mnt/raid
   echo "anddd FINALLY mount the raid on the directory"
   sudo mount LABEL=MY_RAID /mnt/raid

   echo "sample mount line for /etc/fstab"
   echo "LABEL=MY_RAID       /mnt/raid   xfs    defaults,nofail        0       2"
