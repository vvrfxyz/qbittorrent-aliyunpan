#!/bin/bash
#/etc/qBittorrent/config/qBittorrent.conf

service cron start

# check login already or not
aliyunpan who
if [ $? -eq 0 ]
then
  echo "cache token is valid, not need to re-login"
else
  echo "login use refresh token: ${ALIYUNPAN_REFRESH_TOKEN}"
  aliyunpan login -RefreshToken=${ALIYUNPAN_REFRESH_TOKEN}
fi
echo "WebUI\Port=${WEBUI_PORT}" >> /config/qBittorrent/qBittorrent.conf
export XDG_CONFIG_HOME=/config
echo -e "y" | qbittorrent-nox

