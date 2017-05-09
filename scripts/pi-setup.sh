#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "Missing arguments. Please call it with './pi-setup myUserName' where myUserName is the name you want to give to the user that will replace the default pi user."
    exit
fi

USERNAME=$1

echo $USERNAME

exit

# Change root user password (default password is raspberry)
sudo passwd root

# System configuration and upgrade
sudo raspi-config # if keyboard layout modification, etc. are needed
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install xterm vim

# Creates a new user
sudo useradd -m -G adm,dialout,cdrom,sudo,audio,video,plugdev,games,users,input,netdev,gpio,i2c,spi $USERNAME 
sudo passwd $USERNAME
usermod -s /bin/bash $USERNAME
su $USERNAME

# Creates some configuration files for vim, xterm, etc.

cat > ~/.Xresources << "EOF"
xterm*font: 7x13
xterm*background: rgd:00/00/00
EOF

cat > ~/.vimrc << "EOF"
syntax on
set number
set encoding=utf-8
set mouse=a
set pastetoggle=<F2>
EOF

echo 'Do not forget to delete the default pi user with "sudo userdel pi"!'
echo 'Modify /etc/lightdm/lightdm.conf and remove/comment line containing "autologin-user=pi
".'
echo 'If you experience problems deleting the pi user because of processes, run "sudo systemctl stop autologin@tty1 && sudo userdel pi"'
