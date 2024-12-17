FROM		    alpine:3.19.4

ARG				GL_USER=${GL_USER}
ARG				USER_ID=${USER_ID}

# Updating the existing package
RUN				[ "apk", "update" ]
RUN				[ "apk", "upgrade" ]

# Create a user
RUN				adduser -u ${USER_ID} -D ${GL_USER}

RUN				[ "apk", "add", "wget" ]
RUN				[ "apk", "add", "php82", "php82-fpm", "php82-mysqli", "php82-json", "php82-curl", "php82-dom",\
				"php82-exif", "php82-fileinfo", "php82-mbstring", "php82-openssl", "php82-xml", "php82-zip",\
				"php82-mbstring", "php82-phar", "php82-redis" ]

RUN				[ "wget", "https://www.adminer.org/latest.php" ]

RUN				[ "mkdir", "/var/www", "/var/www/html" ]

RUN				[ "mv", "latest.php", "/var/www/html/index.php" ]

RUN				[ "rm", "-rf", "/etc/php82/php-fpm.d/www.conf" ]
ADD				[ "conf/www.conf", "/etc/php82/php-fpm.d/www.conf" ]

RUN				[ "sed", "-i", "s/GL_USER/${GL_USER}/g", "/etc/php82/php-fpm.d/www.conf" ]

RUN				chown -R ${GL_USER}:${GL_USER} /var/www/html

CMD				[ "php-fpm82", "-F" ]