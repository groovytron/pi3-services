#!/bin/bash

# Install nginx http server
sudo apt-get install nginx

# Starts the service
sudo systemctl enable nginx

sudo apt-get install php5 php5-fpm

# set a php powered site
mkdir /var/www/php

sudo cat > /etc/nginx/sites-available/test-php << "EOF"
server {
    listen 80;
    server_name localhost;
    root /var/www/php;
    index index.php index.html index.htm;

    location ~ \.php$ {
        include fastcgi.conf;
        fastcgi_pass  unix:/run/php-fpm/php-fpm.sock;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param QUERY_STRING    $query_string;
    }

    location ~* \.(js|css)$ {
        expires 1h;
    }

    location ~* \.(eot|otf|ttf|woff|woff2)$ {
        add_header Access-Control-Allow-Origin *;
    }
}
EOF

cat > /var/www/php/index.php << "EOF"
<html>
 <head>
  <title>Hello from PHP</title>
 </head>
 <body>
 <?php phpinfo(); ?> 
 </body>
</html>
EOF

ln -sf /etc/nginx/sites-available/test-php /etc/nginx/sites-available/test-php

sudo systemctl enable php-fpm
