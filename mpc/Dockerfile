# Builds a docker gui image
FROM boro/dockergui:x11rdp1.3

LABEL author="Randy Hall <randy.hall@open-source.guru>"

#########################################
##        ENVIRONMENTAL CONFIG         ##
#########################################

# autoinstall from https://raw.githubusercontent.com/aur-archive/raritan-mpc/master/autoinstall.xml
COPY autoinstall.xml /tmp/autoinstall.xml
RUN cd /tmp && \
    curl -o mpc-installer.MPC_7.0.3.5.62.jar.zip \
            https://d3b2us605ptvk2.cloudfront.net/download/kxii/v2.7.0/mpc-installer.MPC_7.0.3.5.62.jar.zip && \
    unzip mpc-installer.MPC_7.0.3.5.62.jar.zip && \ 
    java -jar "mpc-installer.MPC_7.0.3.5.62.jar" autoinstall.xml && \
    rm -rf /tmp/mpc-installer.MPC_* /tmp/autoinstall.xml /var/lib/apt/lists/*

# install java from https://github.com/jachinte/oracle-jdk-1.6.0_23
RUN cd /tmp && \
    wget https://github.com/jachinte/oracle-jdk-1.6.0_23/raw/master/jdk-6u23-linux-x64.bin && \
    ls -la && \
    chmod a+x jdk-6u23-linux-x64.bin && \
    mkdir -p /usr/java && \
    ./jdk-6u23-linux-x64.bin && \
    mv jdk1.6.0_23 /usr/java/latest && \
    rm -f jdk-6u23-linux-x64.bin

# Set environment variables
# User/Group Id gui app will be executed as default are 1000 and 1000
# Gui App Name default is "GUI_APPLICATION"
# Default resolution, change if you like
ENV USER_ID=1000 \
    GROUP_ID=1000 \
    APP_NAME="Multi-Platform Client 7.0.3.5.62" \
    WIDTH=1280 \
    HEIGHT=720 \
    EDGE=0

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

