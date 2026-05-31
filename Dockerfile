FROM jlesage/baseimage-gui:debian-13-v4.2

ENV DEBIAN_FRONTEND=noninteractive \
    DISPLAY=:1 \
    SCREEN_WIDTH=1280 \
    SCREEN_HEIGHT=720 \
    SCREEN_DEPTH=24 \
    APP_NAME="Wireshark" \
    WIRESHARK_RUN_DUMPCAP_AS_ROOT=1

# --------------------------------------------------
# noVNC resize fix
# --------------------------------------------------
RUN sed -i "s/UI.initSetting('resize', resize);/UI.initSetting('resize', 'remote');/g" \
    /opt/noVNC/app/ui.js

# --------------------------------------------------
# Preseed Wireshark install
# --------------------------------------------------
RUN echo "wireshark-common wireshark-common/install-setuid boolean false" | debconf-set-selections

RUN echo "=== USERS ===" && \
    getent passwd root && \
    getent group root && \
    echo "=== LOG DIR ===" && \
    ls -ld /var/log && \
    whoami

# --------------------------------------------------
# Install Wireshark + tools
# Debian 13 has Wireshark 4.4 packages
# --------------------------------------------------
# Preseed wireshark debconf and install dependencies in one layer
RUN echo "wireshark-common wireshark-common/install-setuid boolean false" | debconf-set-selections && \
    apt-get update && \
    apt-get install -y --no-install-recommends wireshark 



# ----------------------------
# Start script
# ----------------------------
COPY startapp.sh /startapp.sh
RUN chmod +x /startapp.sh