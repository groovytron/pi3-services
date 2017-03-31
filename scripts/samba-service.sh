#! /bin/bash

SMB_GROUP=partage
USER_IN_SMB_GROUP=youUserNameHere
SMB_DIR=/media/samba_share

# Install dependencies
sudo apt-get install apache2 samba samba-common-bin

# Create samba group and add a UNIX user to is
sudo addgroup SMB_GROUP

sudo usermod -G SMB_GROUP USER_IN_SMB_GROUP

# Create user in Samba
sudo smbpasswd -a USER_IN_SMB_GROUP

# Create a samba directory to share
sudo mkdir -p SMB_DIR

# Change directory ownership and permissions
sudo chown -R USER_IN_SMB_GROUP:SMB_GROUP SMB_DIR

sudo chmod -R 750 SMB_DIR

# Samba configuration
sudo mv /etc/samba/smb.conf /etc/samba/smb.conf.old

su
cat > /etc/samba/smb.conf << EOF
[global] 
workgroup = WORKGROUP 
server string = %h 
security = user 

[$(basename SMB_DIR)] 
comment = Folder shared with user of the @$SMB_GROUP
path = "$SMB_DIR" 
browseable = yes 
read only = no 
writable = yes 
valid users = @$SMB_GROUP
create mask = 0750 
directory mask = 0750
EOF

# Start the service
sudo /etc/init.d/samba start

