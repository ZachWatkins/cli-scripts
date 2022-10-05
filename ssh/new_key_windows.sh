#!/bin/bash
# Add a SSH Key
# "You should not use the Open SSH client that comes with Git for Windows."
# "Instead, Windows 10 has its own implementation of Open SSH that is integrated with the system."
git config --global core.sshCommand C:/Windows/System32/OpenSSH/ssh.exe
# "Configure SSH to automatically add the keys to the agent on startup by editing the config file found at $HOME\.ssh\config and add the following lines:"
# Host github.com
#     HostName github.com
#     AddKeysToAgent yes
#     IdentitiesOnly yes
#     User <username>
#     IdentityFile ~/.ssh/<your_file_name>
# Add your SSH key to the ssh-agent by issuing the ssh-add command. Enter your passphrase when prompted.
ssh-add $HOME/.ssh/<your_file_name>
