#! /bin/bash

USERNAME=$(whoami)


echo -n "Enter your Samba server name or IP: "
read SMB_HOST
#echo -n "Enter your Samba directory name: "
#read SMB_DIR
#echo -n "Enter your Samba username: "
#read SMB_USER
#echo -n "Enter your Samba password: "
#read -s SMB_PASSWORD

smbclient -L $SMB_HOST -U%

#SMB_TEST_DIR=test-samba
#mkdir $SMB_TEST_DIR

#echo "Mounting..."
#echo

#sudo mount -t cifs //$SMB_HOST/$SMB_DIR $SMB_TEST_DIR/ -o user=$USERNAME,password=$SMB_PASSWORD,workgroup=workgroup,uid=$(id -u $USERNAME),gid=$(id -g $USERNAME)

#echo "Unmouting..."
#echo

#sudo umount $SMB_TEST_DIR || sudo fusermount -u $SMB_TEST_DIR
#rm -r $SMB_TEST_DIR

#echo "Done"
#echo

