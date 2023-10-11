#!/bin/bash

# activation du mode debogage du script -> x trace les cmdes, v verbose
set -xv

# verification que wp-config.php n'existe pas [block if else fi]
if [ -f "./wp-config.php" ]; then 
    echo "[log] The file wp-config.php is set"

else
    # verifie que mariadb a fini ses config avant de continuer
    until mysqladmin -hmariadb -u$MYSQL__DB_USER -p$MYSQL__DB_PASSWORD ping \
		&& mariadb -hmariadb -u$MYSQL__DB_USER -p$MYSQL__DB_PASSWORD -e "SHOW DATABASES;" \
		| grep "$MYSQL__DB_NAME"; \
		do
		sleep 1
	done
    
    # debogage demande :
    wp core download --allow-root

    # Configuration de WordPress avec WP-CLI
    wp core config  --dbname=$MYSQL__DB_NAME \
                    --dbuser=$MYSQL__DB_USER \
                    --dbpass=$MYSQL__DB_PASSWORD \
                    --dbhost=$MYSQL__DB_HOST \
                    --dbprefix=$MYSQL__PREFIX \
                    --allow-root

    wp core install --url=$DOMAIN_URL \
                    --title="Success! This is fucking working!" \
                    --admin_user=$WP__ADMIN_USER \
                    --admin_password=$WP__ADMIN_PASS \
                    --admin_email=$WP__ADMIN_MAIL \
                    --allow-root

    wp user create $WP__USER $WP__USER_MAIL \
        --role=subscriber \
		--user_pass=$WP__USER_PASS \
        --display_name=$WP__USER_DISPLAY_NAME \
        --allow-root

    wp theme install colibri-wp --allow-root --activate

#  ### REDIS ###
    wp config set WP_CACHE_KEY_SALT $MY_REDIS_KEY --allow-root

    # adjust Redis host and port if necessary 
	wp config set WP_REDIS_HOST redis --allow-root
	wp config set WP_REDIS_PORT 6379 --allow-root

    # change the prefix and database for each site to avoid cache data collisions
    wp config set WP_REDIS_PREFIX wpred_ --allow-root
    wp config set WP_REDIS_DATABASE 0 --allow-root

    # reasonable connection and read+write timeouts
    wp config set WP_REDIS_TIMEOUT 1 --allow-root
    wp config set WP_REDIS_READ_TIMEOUT 1 --allow-root

    # install, activate & enable the plugin
    wp plugin install redis-cache --activate --allow-root
    wp plugin update --all --allow-root
    wp redis enable  --allow-root

#  ### REDIS ###

fi

chown -R www-data:www-data /var/www/html/

exec "$@"