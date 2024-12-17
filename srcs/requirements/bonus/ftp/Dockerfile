# For Filezilla:
# Host: mhaouas.42.fr
# Username: $GL_USER
# Password: $USER_PASS

FROM		    alpine:3.19.4

# Updating the existing package
RUN				[ "apk", "update" ]
RUN				[ "apk", "upgrade" ]

# Install the ftp server and shadow to handle password
RUN				[ "apk", "add", "vsftpd", "shadow" ]

# Create /var/www/html
RUN				[ "mkdir", "-p", "/var/www", "/var/www/html" ]	

# Create a logfile for vsftpd
RUN				[ "touch", "/var/log/vsftpd.log" ]

# Create a userlist for vsftpd
RUN				[ "touch", "/etc/vsftpd/vsftpd.userlist" ]

# replace vsftpd's configuration file
RUN				[ "rm", "-f", "/etc/vsftpd/vsftpd.conf" ]
COPY			[ "conf/vsftpd.conf", "/etc/vsftpd/vsftpd.conf" ]

# Add and change permission for our script
ADD				[ "tools/start_service.sh", "." ]
RUN				[ "chmod", "777", "./start_service.sh" ]

# Run the script
CMD				[ "./start_service.sh" ]