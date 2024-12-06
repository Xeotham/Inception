FROM alpine:3.19.4

RUN			[ "apk", "update" ]
RUN			[ "apk", "upgrade" ]

RUN			[ "apk", "add", "mariadb", "mariadb-client", "mariadb-common" ]
RUN			[ "apk", "add", "openrc" ]

RUN			[ "rm", "-f", "/etc/my.cnf.d/mariadb-server.cnf" ]

COPY		[ "conf/mariadb-server.cnf", "/etc/my.cnf.d/mariadb-server.cnf" ]

RUN			[ "openrc" ]
RUN			[ "touch", "/run/openrc/softlevel" ]

ADD			[ "tools/start_service.sh", "." ]

RUN			[ "chmod", "777", "./start_service.sh" ]

CMD     	["./start_service.sh"]