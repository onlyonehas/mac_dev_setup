# Fig pre block. Keep at the top of this file.
. "$HOME/.fig/shell/zshrc.pre.zsh"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Which plugins would you like to load?
plugins=(
git
zsh-autosuggestions
zsh-z
)

source $ZSH/oh-my-zsh.sh

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

eval "$(starship init zsh)"

# git
function branch { git checkout -b $@}
function checkout { git checkout $@}
function commit { git add . && git commit -a -m $@ }
alias pull="git fetch && git pull"
alias push="git push"
alias status="git status"
alias master="git checkout master &&  pull"
alias main="git checkout main && pull"
alias gitreset="git reset --hard"
alias goback="git checkout -"
alias undocommit="git reset --soft HEAD~1"
alias gh="open \`git remote -v | grep git@github.com | grep fetch | head -1 | cut -f2 | cut -d' ' -f1 | sed -e's/:/\//' -e 's/git@/http:\/\//'\`"

# directory
alias sites="cd ~/sites"
alias documents="cd ~/Documents"
alias downloads="cd ~/Downloads"
alias back="cd -"
alias sourcealias="source ~/.zshrc"
alias openalias="vim ~/.zshrc"
alias codealias="code ~/.zshrc"

# npm
alias t="npm t"
alias ni="npm i"

#  auto nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# common functions
function grephistory() { 
  history|grep $1
}

function cmpname() {
  echo $(basename $(pwd))
}

function jen() {
  echo "opening jenkins $(cmpname)"
  open ""  # <- REPLACE URL HERE 
}

function awsdev() {
  echo "opening tooling  aws"
  open "" # <- REPLACE URL HERE 
}

function nls() {
  echo npm ls $1
  npm ls '\@ibl/$1'
}

function clone() {
      git clone git@github.com:bbc/$1.git
      cd $1
}

function go() {
  sites
  if [ -d "$1" ]; then
    echo "Directory found \n"
    echo "Now in: /sites/$1"
    cd $1 && git pull 
  else
    echo "cloning repo $1"
    clone $1
  fi
}

eval "$(starship init zsh)"
PATH="$HOME/sites/bashfiles/:$PATH"

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  
export GPG_TTY=$(tty)

# Fig post block. Keep at the bottom of this file.
. "$HOME/.fig/shell/zshrc.post.zsh"
