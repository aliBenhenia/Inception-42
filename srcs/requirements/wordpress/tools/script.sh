 !/bin/sh


sleep 10


service php7.4-fpm start


mkdir -p /var/www/html
cd /var/www/html


wp core download --allow-root


wp config create --allow-root --dbname=$MARIADB_DATABASE --dbuser=$MARIADB_USER --dbpass=$MARIADB_PASSWORD --dbhost=$DB_HOST


wp core install --allow-root --url=$WP_URL --title=$WP_TITLE --admin_user=$WP_ADMIN_LOGIN --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL


wp user create --allow-root $WP_USER_LOGIN $WP_USER_EMAIL --user_pass=$WP_USER_PASSWORD --role=$WP_USER_ROLE


service php7.4-fpm stop


php-fpm7.4 -F
