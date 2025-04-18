#!/usr/bin/env bash

# Prompt for sudo access upfront to avoid multiple prompts later
sudo -v

# Keep-alive until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Mac software update (commented out if you don't want it)
# updates=$(softwareupdate --list 2>&1)
# if [[ "$updates" != *"No new software available"* ]]; then
#   echo "Updates available, installing..."
#   sudo softwareupdate --install --all  
# else
#   echo "No updates available, skipping installation."
# fi

# Xcode installation 
xcode-select --install || echo "Xcode command line tools already installed."

# Install Oh My Zsh, zsh-autosuggestions, and Zsh-z if not installed
if ! command -v zsh-autosuggestions &>/dev/null; then
  echo "Installing zsh-autosuggestions..."
  brew install zsh-autosuggestions || echo "zsh-autosuggestions already installed."
fi

if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z" ]; then
  echo "Cloning zsh-z plugin..."
  git clone https://github.com/agkozak/zsh-z ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z || echo "zsh-z already cloned."
fi

# Install Homebrew if not installed
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || echo "Homebrew installation failed."
else
  echo "Homebrew is already installed."
fi

# Add Homebrew to path (if not already done)
if ! grep -q 'eval "$(/opt/homebrew/bin/brew shellenv)"' ~/.zprofile; then
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)" || echo "Failed to add Homebrew to path."
else
  echo "Homebrew already in path."
fi

brew update || echo "Failed to update Homebrew."

# Install essential non-GUI apps if not already installed
apps=(python starship awscli redis java jq)
for app in "${apps[@]}"; do
  if ! brew list "$app" &>/dev/null; then
    echo "Installing $app..."
    brew install "$app" || echo "Failed to install $app."
  else
    echo "$app is already installed."
  fi
done

# Install npm packages if not already 
npm_packages=(np aws-cdk)
for pkg in "${npm_packages[@]}"; do
  if ! npm list -g "$pkg" &>/dev/null; then
    echo "Installing $pkg..."
    npm install -g "$pkg" || echo "Failed to install $pkg."
  else
    echo "$pkg is already installed."
  fi
done

# Fonts installation 
fonts=(sfnt2woff sfnt2woff-zopfli woff2)
for font in "${fonts[@]}"; do
  if ! brew list "$font" &>/dev/null; then
    echo "Installing $font..."
    brew install "$font" || echo "Failed to install $font."
  else
    echo "$font is already installed."
  fi
done

# Install essential GUI apps with check for existing installation in /Applications
gui_apps=(
  "font-hack-nerd-font"
  "warp"
  "google-chrome"
  "firefox"
  "slack"
  "numi"
  "zoom"
  "visual-studio-code"
  "maccy"
  "gpg-suite"
  "flux"
  "sublime-text"
  "raycast"
  "microsoft-outlook"
  "postman"
  "docker"
)

for app in "${gui_apps[@]}"; do
  # Check if the app is already in /Applications or installed by Homebrew
  if [ -d "/Applications/$app.app" ] || brew list --cask "$app" &>/dev/null; then
    echo "$app is already installed in /Applications or via Homebrew."
  else
    echo "Installing $app..."
    brew install --cask --appdir="/Applications" "$app" || echo "Failed to install $app."
  fi
done

# Cleanup
brew cleanup || echo "Failed to cleanup Homebrew."

# Personal folder structure
mkdir -p ~/sites || echo "Failed to create ~/sites."

# Download .zshrc from GitHub 
GITHUB_ZSHRC_URL="https://raw.githubusercontent.com/onlyonehas/mac_dev_setup/main/.zshrc"
if ! curl -s $GITHUB_ZSHRC_URL -o ~/.zshrc; then
  echo "Failed to download .zshrc."
else
  source ~/.zshrc
  echo ".zshrc successfully updated."
fi

# Download and configure starship.toml
GITHUB_STARSHIP_URL="https://raw.githubusercontent.com/onlyonehas/mac_dev_setup/main/startship.toml"
mkdir -p ~/.config || echo "Failed to create config directory."
if ! curl -s $GITHUB_STARSHIP_URL -o ~/.config/starship.toml; then
  echo "Failed to download starship.toml."
else
  echo "starship.toml successfully updated."
fi

# Uncomment below if needed
# brew install --cask --appdir="/Applications" cheatsheet
# brew install --cask --appdir="/Applications" alfred
# brew install remotemobprogramming/brew/mob
# brew upgrade remotemobprogramming/brew/mob
# brew install --cask --appdir="/Applications" 1clipboard
# brew install --cask --appdir="/Applications" sourcetree
