# Personal Mac Dev Setup 💻

---

## Description

On many occassions, I had to change laptops, which meant
I had to install ALL the things in the world, 
like **everything** again from scratch.

_So_... wrote this basic script to automate the process.

## Prerequisite

Install x-code which contains dev env for mac

> https://developer.apple.com/download/all/?q=command%20line%20tools

---

# How to run the script

```
chmod 755 setup.sh
./setup.sh


```

## Still TO DO:

- [ ] Automate dot files
- [ ] Store secrets ie .aws, cers
- [ ] Hidden script to move/apply secrets
- [ ] Settings for vscode
- [ ] Alfred shortcuts 

Google Chrome:
Ensure to sign in and turn on sync in Chrome
to keep your browser customisation - bookmarks, extensions etc

Vs Code Sync:
You can turn on Settings Sync using the Turn On Settings Sync... entry in the Manage gear menu at the bottom of the Activity Bar.

> https://code.visualstudio.com/docs/editor/settings-sync

### To add in `.zshrc`

```
plugins=(z, zsh-autosuggestions)
eval "$(starship init zsh)"
```

---

## Github machine setup

### SSH:

To Generate an SSH key:

````  
ssh-keygen
cat ~/.ssh/id_rsa.pub | pbcopy
```  

### GPG:

If you are on version 2.1.17 or greater, paste the text below to generate a GPG key pair.

    gpg --full-generate-key

Use the gpg --list-secret-keys --keyid-format=long command to list the long form of the GPG keys

    gpg --list-secret-keys --keyid-format=long

Copy Id after the `sec 4096R/`

    gpg --armor --export **GPG key ID**
````
