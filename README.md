# Description
On many occassions I had to change laptops, which required to 
install everything from scratch.

So wrote this basic script to automate the process

# Personal Mac Dev Setup

install x-code which contains dev env for mac 
//https://developer.apple.com/download/all/?q=command%20line%20tools

# How to run the script 

```
    chmod 755 setup.sh
    ./setup.sh
```

# TO DO: automate dot files 

### Add in `.zshrc`
```
plugins=(z, zsh-autosuggestions)
eval "$(starship init zsh)"
```
# Github machine setup 

To Generate an SSH key:
```
 ssh-keygen
 cat ~/.ssh/id_rsa.pub | pbcopy
```

If you are on version 2.1.17 or greater, paste the text below to generate a GPG key pair.
`gpg --full-generate-key`

Use the gpg --list-secret-keys --keyid-format=long command to list the long form of the GPG keys
`gpg --list-secret-keys --keyid-format=long`

Copy Id after the `sec   4096R/`
`gpg --armor --export **GPG key ID**,`