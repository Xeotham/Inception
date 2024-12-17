FROM		    alpine:3.19.4

# Updating the existing package
RUN				[ "apk", "update" ]
RUN				[ "apk", "upgrade" ]
RUN				[ "apk", "add", "tar" ]

COPY			[ "conf/portainer-2.19.5-linux-amd64.tar.gz", "./portainer.tar.gz" ]
RUN				[ "tar", "-xvf", "portainer.tar.gz" ]
RUN				[ "rm", "-f", "portainer.tar.gz" ]

CMD				[ "/portainer/portainer" ]