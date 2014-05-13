####################################
# Installing composer globally
sudo curl -s https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
sudo /usr/local/bin/composer self-update

# add to ~/.bash_aliases
echo "alias composer='/usr/local/bin/composer'" >> /home/vagrant/.bash_alias
# reload
. /home/vagrant/.bash_alias

# # get permissions in order
sudo mkdir /var/vhosts && sudo chown www-data:www-data /var/vhosts && sudo usermod -a -G www-data vagrant
#sudo reboot

# # install Symfony via composer
sudo composer create-project symfony/framework-standard-edition /var/vhosts/symfony 2.4.*
cd /var/vhosts/symfony
sudo chown www-data:www-data -R ./ && sudo find . -type f -exec chmod 664 {} \; && sudo find . -type d -exec chmod 775 {} \;
sudo chmod +x app/console
sudo rm -rf app/cache/* app/logs/*
sudo setfacl -R -m u:www-data:rwX -m u:`whoami`:rwX app/cache app/logs &&
sudo setfacl -dR -m u:www-data:rwX -m u:`whoami`:rwX app/cache app/logs
#rm -rf /var/www
sudo ln -s /vagrant/symfony/web /var/www
