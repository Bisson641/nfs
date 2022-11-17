sudo -i
mkdir /mnt/nfs_share
echo '192.168.56.10:/var/nfs_share /mnt/nfs_share nfs nfsvers=3,udp 0 0' >> /etc/fstab
reboot
