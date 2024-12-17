#!/bin/sh

# Create a user and set a password if it does not already exist
# and add it to the userlist
if [ id "$GL_USER" &>/dev/null ]; then
    echo "User $GL_USER already exists. Skipping creation."
else
	adduser -h /var/www/html -s /bin/false -u $USER_ID -D $GL_USER
    echo "$GL_USER:$USER_PASS" | chpasswd
    chown -R $GL_USER:$GL_USER /var/www/html /var/log/vsftpd.log
    echo $GL_USER >> /etc/vsftpd/vsftpd.userlist
fi

# Execute vsftpd
vsftpd /etc/vsftpd/vsftpd.conf