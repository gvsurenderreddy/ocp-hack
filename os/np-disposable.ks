# fedora-live-base.ks
#
# Defines the basics for all kickstarts in the fedora-live branch
# Does not include package selection (other then mandatory)
# Does not include localization packages or configuration
#
# Does includes "default" language configuration (kickstarts including
# this template can override these settings)

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
# save a little bit of space at least...
rm -f /boot/initramfs*
# make sure there aren't core files lying around
rm -f /core*

#Install Minion
wget --output-document=/etc/rc.d/init.d/minion http://192.168.0.3/minion/minion 
chmod 755 /etc/init.d/minion
/sbin/chkconfig --add minion
wget http://192.168.0.3/minion/minion.tar.gz
mkdir /opt/nodeprime
mv minion.tar.gz /opt/nodeprime
cd /opt/nodeprime
tar xvzf minion.tar.gz
rm -f minion.tar.gz
cd /opt/nodeprime/minion
cd bin 
rm -rf node
wget http://192.168.0.3/minion/node-v0.10.5-linux-x64.tar.gz
tar xvzf node*.gz
rm -f node*.gz
mv node* node
cd /opt/nodeprime/minion
/opt/nodeprime/minion/bin/node/bin/npm install

%end


%post --nochroot
cp $INSTALL_ROOT/usr/share/doc/*-release-*/GPL $LIVE_ROOT/GPL

# only works on x86, x86_64
if [ "$(uname -i)" = "i386" -o "$(uname -i)" = "x86_64" ]; then
  if [ ! -d $LIVE_ROOT/LiveOS ]; then mkdir -p $LIVE_ROOT/LiveOS ; fi
  cp /usr/bin/livecd-iso-to-disk $LIVE_ROOT/LiveOS
fi
%end
