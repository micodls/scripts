#!/usr/bin/env bash
# CentOS Virtual Machine Setup

cd ~

sudo yum install git

sudo yum groupinstall "Development tools"
sudo yum install zlib-devel
sudo yum install bzip2-devel
sudo yum install openssl-devel
sudo yum install ncurses-devel
sudo yum install sqlite-devel
sudo yum install readline-devel
sudo yum install tk-devel
sudo yum install gcc
sudo yum install libffi-devel
sudo yum install openssl-devel
sudo yum install python-devel
sudo yum install mysql-devel
sudo yum install cmake
sudo yum install libyaml libyaml-devel
sudo yum install libxml2-devel
sudo yum install ruby ruby-devel
sudo yum install rubygems
sudo yum install rpm-build
# sudo yum install httpd
# sudo yum install telnet

gem install fpm -v 1.4.0

# Python 2.7.11
wget https://www.python.org/ftp/python/2.7.11/Python-2.7.11.tar.xz
tar xf Python-2.7.11.tar.xz
pushd Python-2.7.11
./configure --prefix=/usr/local
make && make altinstall
popd

# Python PIP
wget --no-check-certificate https://bootstrap.pypa.io/get-pip.py
python2.7 get-pip.py
pip install virtualenv

# Start virtualenv
virtualenv <virtualenv_name> -p python2.7
source <virtualenv_name>/bin/activate

# Clone SmartSerice Recode
mkdir smartservicerecode
git clone http://pmdelossantos@10.11.8.1:7990/scm/~pmdelossantos/scripts.git
pushd smartservicerecode
../scripts/checkout_ssr.sh
popd

# .so dependency
echo "export LD_LIBRARY_PATH=/usr/local/lib:/usr/lib:$LD_LIBRARY_PATH" >> ~/.bash_profile
echo "export LD_LIBRARY_PATH=/usr/local/lib:/usr/lib:$LD_LIBRARY_PATH" >> ~/.bashrc
source ~/.bash_profile
source ~/.bashrc

# libev - gevent dependency
wget http://dist.schmorp.de/libev/libev-4.22.tar.gz
tar -xvf libev-4.22.tar.gz
pushd libev-4.22
./configure
make && make install
popd

# Redis
wget http://download.redis.io/releases/redis-2.8.24.tar.gz
tar -xvf redis-2.8.24.tar.gz
pushd redis-2.8.24
make && make install
popd

# For Redis logs and config
echo 1 > /proc/sys/vm/overcommit_memory
mkdir -p /var/log/redis
mkdir -p /etc/redis

# SmartService dependencies
# Install all
# fn + f8 to exit
~/smartservicerecode/smartservice_installers/install_scripts/smartservice_installer

# Start Redis dump services
service redis-low-frequency-dump start
service redis-medium-frequency-dump start
service redis-high-frequency-dump start
chkconfig redis-low-frequency-dump on
chkconfig redis-medium-frequency-dump on
chkconfig redis-high-frequency-dump on

echo 'change <REDIS_MASTER_HOSTNAME> to 127.0.0.1'
sleep 3
vim /etc/redis/redis_sentinel.conf

# Start Redis Sentinel service
service redis-sentinel start
chkconfig redis-sentinel on

# Install SmartService Recode python dependencies
# pip install mmh3
# Python Refactoring
pip install pylint
pip install testfixtures

# Python dependencies
pip install pyyaml
pip install fluent-logger
pip install murmur
pip install ujson
pip install gevent
pip install geventhttpclient
pip install zmq
pip install pysnmp
pip install cython
pip install tldextract
pip install cryptography
pip install scp
pip install flask
pip install readline

# Python documentations
pip install sphinx
pip install sphinxcontrib-napoleon
pip install sphinx_rtd_theme

# Install OSA
pushd ~/SmartService/osa
sudo rm -rf build/ osa.egg-info/
python setup.py install
popd

# Install Core
pushd ~/SmartService/commons/smartservice/core
sudo rm -rf *.html *.c *.so *.pyc
popd
pushd ~/SmartService/commons
sudo rm -rf build/ smartservice.egg-info/
python setup.py install
popd

# Install SNMPler
pushd ~/SmartService/smartservice_installer/rpms
yum install smartservice-python-snmpler-0.0.1b-1.x86_64.rpm
popd
cp -r /opt/lib/python2.7/site-packages/snmpler/ ~/<virtualenv_name>/lib/python2.7/site-packages

# Install gredis
scp -r root@10.11.90.216:~/waki/gredis/ ~
pushd ~/gredis
sudo rm -rf build/ gredis.egg-info/
pushd hiredis
make clean
make static
popd
python setup.py install
# python test/all.py
popd

# td-agent
curl -L https://toolbelt.treasuredata.com/sh/install-redhat-td-agent2.sh | sh
td-agent-gem install fluent-plugin-mysql
mkdir -p /var/opt/smartservice/apple_push_notification/
mkdir -p /var/opt/smartservice/captive_portal/
mkdir -p /var/opt/smartservice/captive_portal_api/
mkdir -p /var/opt/smartservice/config_api/
mkdir -p /var/opt/smartservice/customer_service_api/
mkdir -p /var/opt/smartservice/default_config_webtool/
mkdir -p /var/opt/smartservice/diameter_rf_plus_server/
mkdir -p /var/opt/smartservice/events_api/
mkdir -p /var/opt/smartservice/file_synchronizer/
mkdir -p /var/opt/smartservice/google_cloud_messaging/
mkdir -p /var/opt/smartservice/httplib/
mkdir -p /var/opt/smartservice/mobile_application_api/
mkdir -p /var/opt/smartservice/monitor/
mkdir -p /var/opt/smartservice/mui_sms/
mkdir -p /var/opt/smartservice/mui_ussd/
mkdir -p /var/opt/smartservice/notification_engine/
mkdir -p /var/opt/smartservice/ocs/
mkdir -p /var/opt/smartservice/packages_api/
mkdir -p /var/opt/smartservice/sms_gateway/
mkdir -p /var/opt/smartservice/spa/
chown -R td-agent:td-agent /var/opt/smartservice/
cp /etc/td-agent/td-agent.conf /etc/td-agent/td-agent.conf.bak
cp /etc/td-agent/td-agent_aggregator.conf /etc/td-agent/td-agent.conf
echo "Edit FLUENT_AGGREGATOR_ACTIVE_HOSTNAME and FLUENT_AGGREGATOR_BACKUP_HOSTNAME"
sleep 3
vim /etc/td-agent/td-agent.conf
service td-agent start
chkconfig td-agent on

# httplib dependencies
git clone https://github.com/roadman/fluent-logger-c.git
pushd fluent-logger-c/
make && make install
popd

wget -N https://download.libsodium.org/libsodium/releases/libsodium-1.0.10.tar.gz  --no-check-certificate
tar xvf libsodium-1.0.10.tar.gz
pushd libsodium-1.0.10
./configure
make && make install
popd

wget -O zeromq-4.1.4.tar.gz https://github.com/zeromq/zeromq4-1/releases/download/v4.1.4/zeromq-4.1.4.tar.gz -N
tar xvf zeromq-4.1.4.tar.gz
pushd zeromq-4.1.4
./configure
make && make install
popd

wget -N https://github.com/jbeder/yaml-cpp/archive/release-0.3.0.tar.gz -O release-0.3.0.tar.gz
tar xvf release-0.3.0.tar.gz
pushd yaml-cpp-release-0.3.0/
mkdir build
pushd build
cmake -DBUILD_SHARED_LIBS=ON ..
make && make install
popd
popd
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig

wget https://github.com/miloyip/rapidjson/archive/v1.0.2.tar.gz -O rapidjson-1.0.2.tar.gz
tar xvf rapidjson-1.0.2.tar.gz
pushd rapidjson-1.0.2/
mkdir build
pushd build
cmake
make && make install
popd
popd

# close firewall - for web server
service iptables stop