sudo -i
cd /etc/yum.repos.d/
sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
yum install nfs-utils -y
mkdir /var/nfs_share
echo '/var/nfs_share/ *(rw)' >> /etc/exports
exportfs -rav
systemctl enable nfs-server
systemctl start nfs-server
systemctl enable firewalld
systemctl start firewalld
firewall-cmd --zone=public --add-service=nfs --permanent
firewall-cmd --zone=public --add-port=2049/udp --permanent
firewall-cmd --zone=public --add-port=20048/udp --permanent
firewall-cmd --zone=public --add-port=137/udp --permanent
firewall-cmd --zone=public --add-port=111/udp --permanent
firewall-cmd --reload
cd /etc/
sed -i 's/\# tcp=y/tcp=n/g' nfs.conf
sed -i 's/\# vers3=y/vers3=y/g' nfs.conf
sed -i 's/\# vers4=y/vers4=n/g' nfs.conf
sed -i 's/\# vers4.0=y/vers4.0=n/g' nfs.conf
sed -i 's/\# vers4.1=y/vers4.1=n/g' nfs.conf
sed -i 's/\# vers4.2=y/vers4.2=n/g' nfs.conf
sed -i 's/\# vers2=n/udp=y/g' nfs.conf
systemctl restart nfs-server
