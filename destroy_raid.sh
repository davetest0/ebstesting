sudo mdadm --detail /dev/md0
sudo mdadm --stop /dev/md0
echo "for some reason this gives an error, apparently --stop does all the work?"
sudo mdadm --remove /dev/md0
