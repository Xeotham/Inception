FROM		    alpine:3.19.4

# Updating the existing package
RUN				[ "apk", "update" ]
RUN				[ "apk", "upgrade" ]

# Install all PhP and Mariadb
RUN				[ "apk", "add", "php82", "php82-fpm", "php82-mysqli", "php82-json", "php82-curl", "php82-dom",\
				"php82-exif", "php82-fileinfo", "php82-mbstring", "php82-openssl", "php82-xml", "php82-zip",\
				"php82-mbstring", "php82-phar", "php82-redis" ]
RUN				[ "apk", "add", "mariadb-client" ]

# Install wget to get the WordPress package and tar to uncompress it
RUN				[ "apk", "add", "wget" ]
RUN				[ "apk", "add", "tar" ]

# Replace the php configuration file (Adding 'listen = wordpress:9000')
RUN				[ "rm", "-rf", "/etc/php82/php-fpm.d/www.conf" ]
ADD				[ "conf/www.conf", "/etc/php82/php-fpm.d/www.conf" ]

# Setup Wordpress
RUN 			[ "wget", "https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar" ]
RUN 			[ "chmod", "777", "wp-cli.phar" ]
RUN 			[ "mv", "./wp-cli.phar", "/usr/bin/wp-cli.phar" ]

# Add the bash scrypt start_service and execute it
ADD				[ "tools/start_service.sh", "." ]
RUN         	[ "chmod", "777", "start_service.sh" ]
CMD				[ "./start_service.sh" ]