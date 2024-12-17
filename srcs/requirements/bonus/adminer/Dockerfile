# For Adminer
# System: MySQL
# Server: mariadb
# Username: $MARIADB_USER
# Password: $MARIADB_PASSWORD
# Database: $MARIADB_DATABASE

FROM		    alpine:3.19.4

ARG				GL_USER=${GL_USER}
ARG				USER_ID=${USER_ID}

# Updating the existing package
RUN				[ "apk", "update" ]
RUN				[ "apk", "upgrade" ]

# Create a user
RUN				adduser -u ${USER_ID} -D ${GL_USER}

# Install wget and PhP
RUN				[ "apk", "add", "wget" ]
RUN				[ "apk", "add", "php82", "php82-fpm", "php82-mysqli", "php82-json", "php82-curl", "php82-dom",\
				"php82-exif", "php82-fileinfo", "php82-mbstring", "php82-openssl", "php82-xml", "php82-zip",\
				"php82-mbstring", "php82-phar", "php82-redis" ]

# Get the adminer file to connect our site to adminer
RUN				[ "wget", "https://www.adminer.org/latest.php" ]

# Create /var/www/html
RUN				[ "mkdir", "-p", "/var/www", "/var/www/html" ]

# Move and rename the adminer file
RUN				[ "mv", "latest.php", "/var/www/html/index.php" ]

# Replace the PhP configuration file 
RUN				[ "rm", "-rf", "/etc/php82/php-fpm.d/www.conf" ]
ADD				[ "conf/www.conf", "/etc/php82/php-fpm.d/www.conf" ]
RUN				[ "sed", "-i", "s/GL_USER/${GL_USER}/g", "/etc/php82/php-fpm.d/www.conf" ]

# Change the owner of the file to the user created before
RUN				chown -R ${GL_USER}:${GL_USER} /var/www/html

# Execute PhP
CMD				[ "php-fpm82", "-F" ]