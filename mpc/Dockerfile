# Builds a docker gui image
FROM hurricane/dockergui:x11rdp1.3

MAINTAINER randy.hall@open-source.guru

#########################################
##        ENVIRONMENTAL CONFIG         ##
#########################################

ADD java.tgz /
COPY extract /tmp/extract
RUN cd /tmp && \
    apt-get update && \
    apt-get install -y --no-install-recommends expect && \
    curl -o mpc-installer.MPC_7.0.3.5.62.jar.zip \
            https://d3b2us605ptvk2.cloudfront.net/download/kxii/v2.7.0/mpc-installer.MPC_7.0.3.5.62.jar.zip && \
    unzip mpc-installer.MPC_7.0.3.5.62.jar.zip && \ 
    chmod a+x extract && \
    ./extract && \
    rm -rf /tmp/mpc-installer.MPC_* /tmp/extract /var/lib/apt/lists/*

# Set environment variables
# User/Group Id gui app will be executed as default are 1000 and 1000
# Gui App Name default is "GUI_APPLICATION"
# Default resolution, change if you like
ENV USER_ID=1000 \
    GROUP_ID=1000 \
    APP_NAME="Multi-Platform Client 7.0.3.5.62" \
    WIDTH=1280 \
    HEIGHT=720

ADD root /

# Copy X app start script to right location
RUN chmod 555 /startapp.sh /watchapp.sh /etc/rc.local && \
    echo "/usr/java/latest" > /path.conf && \
    ln -s /config/.java /nobody && \
    ln -s /config/ApplicationSettings.xml /nobody && \
    ln -s /config/KeyboardMacros.xml /nobody && \
    ln -s /config/DeviceTree.xml /nobody

#########################################
##         EXPORTS AND VOLUMES         ##
#########################################

# Place whater volumes and ports you want exposed here:
VOLUME ["/config"]
EXPOSE 3389 8080 8081
CMD ["/sbin/my_init"]

