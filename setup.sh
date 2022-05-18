#!/usr/bin/env bash

# Xcode https://developer.apple.com/download/all/?q=command%20line%20tools
# administrator access
sudo -v

# Keep-alive until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install Homebrew
if test ! $(which brew); then
  echo "Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew update

# ohmyzsh and zsh autosuggestions
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash


# Mac software update 
# softwareupdate --all --install --force


brew install node
brew install python
brew install python3
brew install docker
brew install starship
brew install awscli

# fonts.
brew tap bramstein/webfonttools
brew install sfnt2woff
brew install sfnt2woff-zopfli
brew install woff2


# essential apps - gui
brew install --cask --appdir="/Applications" alfred
brew install --cask --appdir="~/Applications" iterm2
brew install --cask adoptopenjdk/openjdk/adoptopenjdk8
brew install --cask --appdir="/Applications" google-chrome
brew install --cask --appdir="/Applications" firefox
brew install --cask --appdir="/Applications" slack
brew install --cask --appdir="/Applications" numi
brew install --cask --appdir="/Applications" zoom.us
brew install --cask --appdir="/Applications" microsoft-outlook
brew install --cask --appdir="/Applications" visual-studio-code
brew install --cask --appdir="/Applications" fig
brew install --cask --appdir="/Applications" 1clipboard


brew cleanup
