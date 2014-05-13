####################################
# Installing composer globally
sudo curl -s https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
# add to ~/.bash_aliases
echo "alias composer='/usr/local/bin/composer'" >> /home/`whoami`/.bash_aliases
# reload
. /home/`whoami`/.bash_aliases

# install Symfony via composer
sudo mkdir /var/vhosts && sudo chown `whoami`:www-data /var/vhosts
composer create-project --prefer-dist -vvv symfony/framework-standard-edition symfony 2.4.*
cd /var/vhosts/symfony
sudo chown `whoami`:www-data -R ./ && sudo find . -type f -exec chmod 664 {} \; && sudo find . -type d -exec chmod 775 {} \;
sudo chmod +x app/console
sudo rm -rf app/cache/* app/logs/*
sudo setfacl -R -m u:www-data:rwX -m u:`whoami`:rwX app/cache app/logs
sudo setfacl -dR -m u:www-data:rwX -m u:`whoami`:rwX app/cache app/logs
sudo rm -rf /var/www
sudo ln -s /var/vhosts/symfony/web /var/www
# this will get you going
# you cant symlink the code into a host accissible location -
# the symlink will try to reference the host file system not the guest file system
#sudo ln -s /var/vhosts/symfony /vagrant/symfony
cd /var/vhosts/symfony

## todo
# add default install to git and replace all of this
# add a virtualhost to the default install