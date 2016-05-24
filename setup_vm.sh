#!/usr/bin/env bash
# CentOS
yum install git
yum groupinstall "Development tools"

# Python 2.7.11
wget https://www.python.org/ftp/python/2.7.11/Python-2.7.11.tar.xz
tar xf Python-2.7.3.tar.bz2
pushd Python-2.7.3
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
mkdir "SmartService Recode"
git clone http://pmdelossantos@10.11.8.1:7990/scm/~pmdelossantos/scripts.git
pushd scripts
./checkout_ssr.sh
popd

# For .so dependency
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

# SmartService dependencies
# Install all
# fn + f8 to exit
SmartService\ Recode/smartservice_installers/install_scripts/smartservice_installer

# For Redis logs and config
mkdir -p /var/log/redis
mkdir -p /etc/redis