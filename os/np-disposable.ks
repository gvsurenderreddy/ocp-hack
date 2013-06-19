# Kickstart for CentOS 6.4 to create disposable OS

lang en_US.UTF-8
keyboard us
network --onboot yes --device eth0 --bootproto dhcp
rootpw  --iscrypted $6$JlUJy7NBAqpnUJ6T$T4z0Xgu82H430OK2o4ED.NVgl5.MOs2N66y1CxtT80CI3efiTmTItjAp.zLlmwxI4E3cvBk9hpJNopge6K4R6/
firewall --service=ssh
authconfig --enableshadow --passalgo=sha512
selinux --enforcing
timezone --utc America/Los_Angeles
services --enabled=network,sshd

repo --name="CentOS"  --baseurl=http://mirror.stanford.edu/pub/mirrors/centos/6.4/os/x86_64/ --cost=100
repo --name="elrepo"  --baseurl=http://elrepo.org/linux/elrepo/el6/x86_64/ --cost=100
repo --name="elrepo-kernel"  --baseurl=http://elrepo.org/linux/kernel/el6/x86_64/ --cost=100
repo --name="elrepo-extras"  --baseurl=http://elrepo.org/linux/extras/el6/x86_64/ --cost=100
repo --name="epel"  --baseurl=http://mirror.pnl.gov/epel/6/x86_64/ --cost=100

%packages
@core
@base
screen
git
wget
kernel-ml
anaconda
fpaste
make
automake
gcc
libtool
pkgconfig
cmake
%end

%post
# Add github.com to host file
echo "204.232.175.90 github.com" >> /etc/hosts

# save a little bit of space at least...
rm -f /boot/initramfs*
# make sure there aren't core files lying around
rm -f /core*

#Install Agent
cd /tmp
git clone https://github.com/NodePrime/ocp-hack.git
mv /tmp/ocp-hack/init/ocp-agent /etc/init.d/ocp-agent
chmod 755 /etc/init.d/ocp-agent
/sbin/chkconfig --add ocp-agent
mkdir /opt/ocp-agent
mv /tmp/ocp-hack/agent /opt/ocp-agent
cd /opt/ocp-agent
/opt/ocp-agent/bin/node/bin/npm install

# Edit grub to allow headless booting
sed -i "s/\(.*\)\(speed\)/#\1\2/g" /boot/grub/grub.conf
%end


%post --nochroot
cp $INSTALL_ROOT/usr/share/doc/*-release-*/GPL $LIVE_ROOT/GPL

# only works on x86, x86_64
if [ "$(uname -i)" = "i386" -o "$(uname -i)" = "x86_64" ]; then
  if [ ! -d $LIVE_ROOT/LiveOS ]; then mkdir -p $LIVE_ROOT/LiveOS ; fi
  cp /usr/bin/livecd-iso-to-disk $LIVE_ROOT/LiveOS
fi
%end
