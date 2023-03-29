#!/bin/bash
sudo yum update -y
sudo yum install -y nginx
sudo systemctl start nginx
sudo chmod 777 -R /var/www/html
echo "<h2>nginx installed by terraform</h2>" > /var/www/html/index.html
sudo systemctl enable nginx

# logdir=/var/log
# logfile=$${logdir}/nginx_setup.log
# exec >> $${logfile} 2>&1