# Path to your oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"

# zsh plugins
plugins=(
  git
  zsh-autosuggestions
  z
)

# Initialize Starship prompt
eval "$(starship init zsh)"

# Source oh-my-zsh
if [[ -s "$ZSH/oh-my-zsh.sh" ]]; then
  source "$ZSH/oh-my-zsh.sh"
else
  echo "Error: oh-my-zsh not found at $ZSH/oh-my-zsh.sh"
  exit 1
fi

# Git aliases and functions
# Function to create and switch to a new branch
function branch() {
  git checkout -b "$@" || echo "Error: Unable to create branch."
}

# Function to checkout an existing branch
function checkout() {
  git checkout "$@" || echo "Error: Unable to checkout branch."
}

# Commit changes with a message
function commit() {
  git add . && git commit -a -m "$@" || echo "Error: Commit failed."
}

alias pull="git fetch && git pull"
alias push="git push"
alias status="git status"
alias master="git checkout master && pull"
alias main="git checkout main && pull"
alias gitreset="git reset --hard"
alias goback="git checkout -"
alias undocommit="git reset --soft HEAD~1"
alias viewbranches="git branch --all"
alias gitlog="git log --graph --all --decorate --oneline"

# Delete last commit(s) with confirmation
alias deletelastcommit='gitdeletecommit() { \
  echo "This will delete the last $1 commit(s) permanently."; \
  read -p "Are you sure? (y/n): " confirm; \
  if [ "$confirm" == "y" ]; then \
    git branch backup-$(date +"%Y%m%d%H%M%S") HEAD; \
    git reset --hard HEAD~$1; \
  else \
    echo "Deletion cancelled."; \
  fi; \
  unset -f gitdeletecommit; \
}; gitdeletecommit'

# Delete commit by hash
deletecommitbyhash() {
  local commit_hash="$1"
  local current_branch
  current_branch="$(git rev-parse --abbrev-ref HEAD)"  # Get the current branch name
  echo "This will delete the commit with hash: $commit_hash permanently."
  
  read -p "Are you sure? (y/n): " confirm
  if [ "$confirm" == "y" ]; then
    git checkout main  # Switch to the main branch
    git branch "backup-$(date +"%Y%m%d%H%M%S")" "$commit_hash"  # Create the backup branch
    git checkout "$current_branch"  # Switch back to the original branch
    git reset --hard "$commit_hash"  # Delete the commit on the original branch
  else
    echo "Deletion cancelled."
  fi
}

# GitHub alias to open repo page
alias gh="open \`git remote -v | grep git@github.com | grep fetch | head -1 | cut -f2 | cut -d' ' -f1 | sed -e's/:/\//' -e 's/git@/http:\/\//' \`"

# Directory navigation aliases
alias sites="cd ~/sites"
alias documents="cd ~/Documents"
alias downloads="cd ~/Downloads"
alias back="cd -"
alias sourcealias="source ~/.zshrc"
alias openalias="code ~/.zshrc"
alias openstarship="code ~/.config/starship.toml"
alias vs="code . -n"
alias gobackf="cd -"
alias bashfiles="code ~/sites/bashfiles"

# Always show hidden files with ls
alias ls='ls -a'

# NPM aliases
alias t="npm t"
alias ni="npm i"

# Auto nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
if [ -s "$NVM_DIR/nvm.sh" ]; then
  \. "$NVM_DIR/nvm.sh"  # Load nvm
else
  echo "Error: nvm not found."
  exit 1
fi

autoload -U add-zsh-hook

# Load nvmrc
load-nvmrc() {
  local node_version nvmrc_path nvmrc_node_version
  node_version="$(nvm version)"
  nvmrc_path="$(nvm_find_nvmrc)"
  
  if [ -n "$nvmrc_path" ]; then
    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install || echo "Error: Failed to install node version."
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use || echo "Error: Failed to switch node versions."
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default || echo "Error: Failed to revert to default version."
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc

# Common functions
function grephistory() {
  history | grep "$1" || echo "Error: No matching history found."
}

function cmpname() {
  echo "$(basename "$(pwd)")"
}

function jen() {
  echo "Opening Jenkins $(cmpname)"
  open ""  # <- Replace URL HERE
}

function awsdev() {
  echo "Opening AWS tooling"
  open ""  # <- Replace URL HERE
}

function clone() {
  git clone git@github.com:onlyonehas/"$1".git || echo "Error: Failed to clone repo."
  cd "$1" || echo "Error: Failed to navigate into $1 directory."
}

function go() {
  sites
  local dir
  dir=$(z "$1" -e)
  if [ -n "$dir" ]; then
    echo "Directory found"
    z "$1" >/dev/null || return
    nvm use && git pull || echo "Error: Failed to set up environment."
  else
    echo "Cloning repo $1"
    clone "$1" || echo "Error: Failed to clone repo $1."
  fi
}

# Add custom path for bashfiles
PATH="$HOME/sites/bashfiles/:$PATH"

# Load nvm bash completion
if [ -s "$NVM_DIR/bash_completion" ]; then
  \. "$NVM_DIR/bash_completion"
else
  echo "Error: nvm bash completion not found."
fi

# Set GPG_TTY for GPG operations
export GPG_TTY=$(tty)
