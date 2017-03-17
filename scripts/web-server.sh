#!/bin/bash

# Install nginx http server
sudo apt-get install nginx

# Starts the service
sudo systemctl enable nginx

sudo apt-get install php5 php5-fpm
