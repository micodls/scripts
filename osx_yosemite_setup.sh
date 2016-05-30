#!/usr/bin/env bash
# install homebrew - counterpart of apt-get
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew update

# Developer tools
brew install wget
brew install git
brew install python
brew install python3
brew install vim
brew install redis
brew install node
brew install rpm

# Python libraries
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
pip install sphinx
pip install sphinxcontrib-napoleon
pip install sphinx_rtd_theme # https://github.com/snide/sphinx_rtd_theme

# JS Web Dev
curl https://install.meteor.com | sh

# Other tools
brew install caskroom/cask/brew-cask
brew tap caskroom/versions
brew cask install --appdir="/Applications" sublime-text3
brew cask install --appdir="/Applications" pycharm-ce
brew cask install --appdir="/Applications" tunnelblick
# mv /opt/homebrew-cask/Caskroom/tunnelblick/3.6.3_build_4560/Tunnelblick.app/ /Applications/

# Nice to have
brew cask install --appdir="/Applications" google-chrome
brew cask install --appdir="/Applications" google-drive
brew cask install --appdir="/Applications" firefox
brew cask install --appdir="/Applications" spotify
brew cask install --appdir="/Applications" shiftit

# Git config
git config --global user.name "Paolo Miguel M. de los Santos"
git config --global user.email mico.delossantos@voyagerinnovation.com
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# Sublime Packages
# Anaconda - Python IDE
# SidebarEnhancement - Addition sidebar options
# rsub - Open files from ssh
#   Command: ssh -R 52968:localhost:52968 username@ip
#   ~/.ssh/config
#   -------------
#   Host *
#       RemoteForward 52698 localhost:52698

# .bash_profile
# echo "HELLO WORLD"
# alias micovm='ssh -R 52968:localhost:52968 root@10.11.4.17'
# alias teamvm='ssh root@10.11.90.216'
