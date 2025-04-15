# Personal Mac Dev Setup 💻

---

## Description

On many occassions, I had to change laptops, which meant I had to install ALL the things in the world, 
like **everything** again from scratch.

_So_... wrote this script to automates that process by setting up all the common development tools and configurations for you. 

From installing essential software to configuring your environment, it handles the tedious tasks so you don’t have to. 

Just run the script, and you're good to go!


# How to run the script

```
GITHUB_SETUP_URL="https://raw.githubusercontent.com/onlyonehas/mac_dev_setup/main/setup.sh"

# Download the setup.sh script from GitHub
curl -O $GITHUB_SETUP_URL

# Make the setup.sh script executable
chmod 755 setup.sh

# Run the setup.sh script
./setup.sh

```

## Still TO DO:
- [ ] Update dynamically from cloud 
- [ ] Automate dot files
- [ ] Secure secrets ie .aws, certs
- [ ] Hidden script to move/apply secrets
- [ ] Settings for vscode
- [ ] Alfred shortcuts 

Google Chrome:
Ensure to sign in and turn on sync in Chrome
to keep your browser customisation - bookmarks, extensions etc

Vs Code Sync:
You can turn on Settings Sync using the Turn On Settings Sync... entry in the Manage gear menu at the bottom of the Activity Bar.

> https://code.visualstudio.com/docs/editor/settings-sync


## Github machine setup
```
# Generate SSH Key if not already present
echo "Checking for existing SSH key..."

if [ ! -f "$HOME/.ssh/id_rsa" ]; then
  echo "No SSH key found. Generating new SSH key..."
  ssh-keygen -t rsa -b 4096 -C "your_email@example.com" -f "$HOME/.ssh/id_rsa" -N ""
else
  echo "SSH key already exists."
fi

# Copy the SSH public key to clipboard (macOS only, adjust for other OS if needed)
echo "Copying SSH public key to clipboard..."
cat ~/.ssh/id_rsa.pub | pbcopy
echo "SSH public key copied to clipboard. Add it to your GitHub account."

# Generate GPG Key
echo "Checking for existing GPG key..."

GPG_KEY=$(gpg --list-secret-keys --keyid-format LONG | grep sec | head -n 1 | awk -F/ '{print $2}' | tr -d ' ')

if [ -z "$GPG_KEY" ]; then
  echo "No GPG key found. Generating new GPG key..."
  gpg --full-generate-key
else
  echo "GPG key already exists."
fi

# List the GPG key ID
GPG_KEY=$(gpg --list-secret-keys --keyid-format LONG | grep sec | head -n 1 | awk -F/ '{print $2}' | tr -d ' ')

echo "Listing GPG key ID..."
echo "Your GPG key ID is: $GPG_KEY"

# Export GPG Key to clipboard
echo "Exporting GPG key to clipboard..."
gpg --armor --export $GPG_KEY | pbcopy
echo "GPG key exported to clipboard. Add it to your GitHub account."

echo "GitHub machine setup complete! Add your SSH and GPG keys to your GitHub account."
```
