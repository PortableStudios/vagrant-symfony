# Vagrant box set up
# https://docs.google.com/a/portable.tv/document/d/1Ti4-w1aM6sWDEtNjLiH4Mpc-D8MTH9m0JGzFYcA2qVU/edit?usp=sharing
# PHP 5.4 is required for Less. if you are <= 12.04

# mysql root pass soe
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password soe'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password soe'

sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/dbconfig-install boolean true'
sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/app-password-confirm password soe'
sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/mysql/admin-pass password soe'
sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/mysql/app-pass password soe'
sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2'
export DEBIAN_FRONTEND=noninteractive

# Upgrade to php5.4
sudo add-apt-repository -y ppa:ondrej/php5-oldstable
# Install NodeJS (required for less, sass)
# https://launchpad.net/~chris-lea/+archive/node.js/
sudo apt-add-repository -y ppa:chris-lea/node.js

sudo apt-get -y update && sudo apt-get -y dist-upgrade
sudo apt-get -y install acl bindfs drush fail2ban git libicu-dev mcrypt mysql-server nodejs php5-curl php5-dev php5-intl php5-mysql phpmyadmin php-pear
sudo hostname symfony.vm
echo 'symfony.vm' | sudo tee -a /etc/hostname
sudo a2enmod rewrite
sudo npm install -g less

#Php Configuration
sed -i "s/upload_max_filesize = 2M/upload_max_filesize = 10M/" /etc/php5/apache2/php.ini
sed -i "s/short_open_tag = On/short_open_tag = Off/" /etc/php5/apache2/php.ini
sed -i "s/;date.timezone =/date.timezone = UTC/" /etc/php5/apache2/php.ini
sed -i "s/;date.timezone =/date.timezone = UTC/" /etc/php5/cli/php.ini
sed -i "s/memory_limit = 128M/memory_limit = 1024M/" /etc/php5/apache2/php.ini
sed -i "s/_errors = Off/_errors = On/" /etc/php5/apache2/php.ini
#sudo bindfs -o perms=0775,mirror=vagrant,group=www-data /home/vagrant/www /var/www
sudo service apache2 restart

# Installing composer globally
sudo curl -s https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
sudo chmod +x /usr/local/bin/composer
# add to ~/.bash_aliases
echo "alias composer='/usr/local/bin/composer'" >> /home/vagrant/.bash_aliases
# reload
. /home/vagrant/.bash_aliases

#is this needed? already installed with apt-get above
#sudo pear install pecl/intl

## other tasks
# SSL / HTTPS
# timezone to UTC
# hostname
