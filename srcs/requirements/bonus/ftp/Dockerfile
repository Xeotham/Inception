FROM		    alpine:3.19.4

# Updating the existing package
RUN				[ "apk", "update" ]
RUN				[ "apk", "upgrade" ]

RUN				[ "apk", "add", "vsftpd", "shadow" ]

RUN				[ "mkdir", "-p", "/var/www", "/var/www/html" ]	

RUN				[ "touch", "/var/log/vsftpd.log" ]

RUN				[ "touch", "/etc/vsftpd/vsftpd.userlist" ]

RUN				[ "rm", "-f", "/etc/vsftpd/vsftpd.conf" ]
COPY			[ "conf/vsftpd.conf", "/etc/vsftpd/vsftpd.conf" ]

ADD				[ "tools/start_service.sh", "." ]
RUN				[ "chmod", "777", "./start_service.sh" ]

CMD				[ "./start_service.sh" ]