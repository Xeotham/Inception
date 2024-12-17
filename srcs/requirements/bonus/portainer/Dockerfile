# For Portainer:
# Link: localhost:9000

FROM		    alpine:3.19.4

# Updating the existing package
RUN				[ "apk", "update" ]
RUN				[ "apk", "upgrade" ]

# Install tar to unzip the portainer file
RUN				[ "apk", "add", "tar" ]

# Add the portainer compressed file to our docker
COPY			[ "conf/portainer-2.19.5-linux-amd64.tar.gz", "./portainer.tar.gz" ]

# Unzip the file and remove it
RUN				[ "tar", "-xvf", "portainer.tar.gz" ]
RUN				[ "rm", "-f", "portainer.tar.gz" ]

# Execute portainer
CMD				[ "/portainer/portainer" ]