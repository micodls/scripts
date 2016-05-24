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
pip install sphinx

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