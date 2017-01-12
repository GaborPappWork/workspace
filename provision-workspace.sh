#!/bin/bash

VERSION_CODENAME="$(lsb_release -c | awk '{ print $2 }')"

# adding keys
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

# adding repositories
echo "deb https://apt.dockerproject.org/repo ubuntu-${VERSION_CODENAME} main" > /etc/apt/sources.list.d/docker.list
add-apt-repository ppa:webupd8team/sublime-text-3
add-apt-repository ppa:ansible/ansible
add-apt-repository ppa:webupd8team/java

echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections

# install & update all the things
apt-get update -y
apt-get install -y --no-install-recommends lubuntu-desktop \
	build-essential \
	git \
	gitk \
	git-gui \
	docker-engine \
	mc \
	htop \
	oracle-java8-installer \
	oracle-java8-set-default \
	ansible \
	sublime-text-installer

apt-get remove -y light-locker

#install docker-compose
curl -L https://github.com/docker/compose/releases/download/1.9.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# dropping ssh keys to the guest machine
cp /vagrant/ssh/* /home/vagrant/.ssh
chown -R vagrant:vagrant /home/vagrant/.ssh
chmod 0500 /home/vagrant/.ssh/*

# Setting timezone and localization
timedatectl set-timezone Europe/Budapest
	# addig Hungarian keyboard to the layouts
echo 'setxkbmap "hu,us" -option "grp:alt_shift_toggle"' >> /home/vagrant/.profile

# auto login with vagrant user
tee /etc/lightdm/lightdm.conf.d/20-lubuntu.conf <<-'EOF'
[SeatDefaults]
autologin-user=vagrant
autologin-user-timeout=0
user-session=Lubuntu
greeter-session=lightdm-gtk-greeter
EOF

# setting up git access
export GIT_SSH=/vagrant/git.sh

usermod -aG docker vagrant

apt-get autoremove -y

shutdown -h now
