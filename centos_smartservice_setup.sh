#!/usr/bin/env bash
# CentOS Virtual Machine Setup

cd ~

sudo yum install git

sudo yum groupinstall "Development tools"
sudo yum install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel

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
mkdir SmartService
git clone http://pmdelossantos@10.11.8.1:7990/scm/~pmdelossantos/scripts.git
pushd SmartService
../scripts/checkout_ssr.sh
popd

# .so dependency
echo "export LD_LIBRARY_PATH=/usr/local/lib:/usr/lib:$LD_LIBRARY_PATH" >> ~/.bash_profile
source ~/.bash_profile

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
~/SmartService/smartservice_installers/install_scripts/smartservice_installer

# Start Redis dump services
service redis-low-frequency-dump start
service redis-medium-frequency-dump start
service redis-high-frequency-dump start
chkconfig redis-low-frequency-dump on
chkconfig redis-medium-frequency-dump on
chkconfig redis-high-frequency-dump on

# change <REDIS_MASTER_HOSTNAME> to 127.0.0.1
vim /etc/redis/redis_sentinel.conf

# Start Redis Sentinel service
service redis-sentinel start
chkconfig redis-sentinel on

# Install SmartService Recode python dependencies
pip install cython gevent pysnmp ujson zmq mmh3 murmur fluent-logger pyyaml

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