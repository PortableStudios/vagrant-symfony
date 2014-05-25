####################################
# install Symfony via composer
# deploying to /tmp, and settings permissions works after you move it to /var/vhosts
# but on linux at least I have it working in place via nfs and bindfs
# So im deploying in place
#composer create-project --prefer-dist -vvv symfony/framework-standard-edition /tmp/symfony 2.4.*
composer create-project --prefer-dist -vvv symfony/framework-standard-edition /var/vhosts/symfony 2.4.*
#cd /tmp/symfony
cd /var/vhosts/symfony
sudo chown `whoami`:www-data -R ./ && sudo find . -type f -exec chmod 664 {} \; && sudo find . -type d -exec chmod 775 {} \;
sudo chmod +x app/console
sudo rm -rf app/cache/* app/logs/*
sudo setfacl -R -m u:www-data:rwX -m u:`whoami`:rwX app/cache app/logs
sudo setfacl -dR -m u:www-data:rwX -m u:`whoami`:rwX app/cache app/logs
#mv /tmp/symfony /var/vhosts
#cd /var/vhosts/symfony

## todo
# add default install to git and replace all of this
# add a virtualhost to the default install
