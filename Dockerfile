FROM jlesage/baseimage-gui:debian-13-v4

ENV DEBIAN_FRONTEND=noninteractive \
    DISPLAY=:1 \
    SCREEN_WIDTH=1280 \
    SCREEN_HEIGHT=720 \
    SCREEN_DEPTH=24 \
    APP_NAME="Wireshark" \
    WIRESHARK_RUN_DUMPCAP_AS_ROOT=1

# ----------------------------
# UI / noVNC tweak
# ----------------------------
RUN sed -i "s/UI.initSetting('resize', resize);/UI.initSetting('resize', 'remote');/g" /opt/noVNC/app/ui.js


# ----------------------------
# Start script
# ----------------------------
COPY startapp.sh /startapp.sh
RUN chmod +x /startapp.sh