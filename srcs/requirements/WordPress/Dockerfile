FROM		    alpine:3.19.4


# Update Alpine Package Keeper
RUN				[ "apk", "update" ]
RUN				[ "apk", "upgrade" ]

# Install PHP
RUN				[ "apk", "add", "php82", "php82-fpm", "php82-mysqli", "php82-json", "php82-curl", "php82-dom",\
				"php82-exif", "php82-fileinfo", "php82-mbstring", "php82-openssl", "php82-xml", "php82-zip",\
				"php82-mbstring", "php82-phar", "php82-redis" ]

RUN				[ "apk", "add", "mariadb-client" ]

# Install utils
RUN				[ "apk", "add", "wget" ]
RUN				[ "apk", "add", "tar" ]

# Setup PHP
RUN				[ "rm", "-rf", "/etc/php82/php-fpm.d/www.conf" ]
ADD				[ "conf/www.conf", "/etc/php82/php-fpm.d/www.conf" ]

# Setup Wordpress
RUN 			[ "wget", "https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar" ]
RUN 			[ "chmod", "777", "wp-cli.phar" ]
RUN 			[ "mv", "./wp-cli.phar", "/usr/bin/wp-cli.phar" ]

# Entrypoint
ADD				[ "tools/start_service.sh", "." ]
RUN         	[ "chmod", "777", "start_service.sh" ]
CMD				[ "./start_service.sh" ]