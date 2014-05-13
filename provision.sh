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

sudo add-apt-repository -y ppa:ondrej/php5-oldstable
sudo apt-get -y update && sudo apt-get -y dist-upgrade
sudo apt-get -y install mcrypt acl libicu-dev php-pear php5-intl php5-dev fail2ban git drush php5-curl sendmail mysql-server php5-mysql phpmyadmin

sudo a2enmod rewrite
sudo service apache2 restart

#is this needed? already installed with apt-get above
#sudo pear install pecl/intl

# Install NodeJS (required for less, sass)
# https://launchpad.net/~chris-lea/+archive/node.js/
sudo apt-add-repository -y ppa:chris-lea/node.js
sudo apt-get update && sudo apt-get -y install nodejs
sudo npm install -g less

## other tasks
# SSL / HTTPS
# timezone to UTC