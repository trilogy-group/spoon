#!/bin/bash

export DEBIAN_FRONTEND="noninteractive"

apt-get update
apt-get install apt-utils --no-install-recommends -y
apt-get upgrade -y
apt-get install software-properties-common curl vim git git-lfs -y

add-apt-repository ppa:webupd8team/java -y
apt-get update
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
apt-get install oracle-java8-installer -y

pushd opt
wget http://www-us.apache.org/dist/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz
tar -xf apache-maven-3.5.4-bin.tar.gz
mv apache-maven-3.5.4/ apache-maven/
popd
update-alternatives --install /usr/bin/mvn maven /opt/apache-maven/bin/mvn 1001

locale-gen en_US en_US.UTF-8
update-locale LANG=en_US.UTF-8
echo 'export LANG=en_US.UTF-8\nexport LC_ALL=en_US.UTF-8' >> ~/.bashrc

apt-get autoremove --yes
apt-get clean all
rm -rf /var/lib/apt/lists/*
rm -f /setup.sh