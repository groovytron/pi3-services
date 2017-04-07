#! /bin/bash

#sudo apt-get install software-properties-common python-software-properties

#sudo add-apt-repository ppa:x2go/stable -y

sudo apt-key adv --recv-keys --keyserver keys.gnupg.net E1F958385BFE2B6E

su

cat > /etc/apt/sources.list.d/x2go.list << EOF
# X2Go Repository (release builds)
deb http://packages.x2go.org/raspbian jessie main
# X2Go Repository (sources of release builds)
deb-src http://packages.x2go.org/raspbian jessie main

# X2Go Repository (nightly builds)
#deb http://packages.x2go.org/raspbian jessie heuler
# X2Go Repository (sources of nightly builds)
#deb-src http://packages.x2go.org/raspbian jessie heuler
EOF

exit

sudo apt-get update

sudo apt-get install x2go-keyring && apt-get update

sudo apt-get -y install x2goserver x2goserver-xsession

# Create x2go database needed by the server
sudo x2godbadmin --createdb

sudo systemctl enable x2goserver
sudo systemctl start x2goserver

sudo apt-get install xfce4 mate-core mate-desktop mate-desktop-environment
