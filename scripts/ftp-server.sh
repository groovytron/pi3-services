#! /usr/bin

FTP_GROUP=ftpgroup
FTP_USER=youFtpUserNameHere
FTP_COMMON_DIR=dirPath

# Install required software
sudo apt-get install pure-ftpd

# Create FTP group and user
sudo groupadd FTP_GROUP

sudo useradd FTP_USER -g FTP_GROUP -s /sbin/nologin -d /dev/null

# Create FTP directory
sudo mkdir FTP_COMMON_DIR

sudo chown -R FTP_USER:FTP_GROUP FTP_COMMON_DIR

sudo chmod a+wrx FTP_COMMON_DIR

# Create an upload user
sudo pure-pw useradd upload -u FTP_USER -g FTP_GROUP -d FTP_COMMON_DIR -m

sudo pure-pw mkdb

# Define authentication method 12 is only for demo
sudo ln -s /etc/pure-ftpd/conf/PureDB /etc/pure-ftpd/auth/12puredb

# Restart the FTP service
sudo service pure-ftpd restart
