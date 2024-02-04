# qbittorrent-aliyunpan
统合qbittorrent和aliyunpan为一个容器，实现qbittorrent下载完成后自动上传至阿里云盘

#### docker-compose方式启动：
```yml
  qbittorrent: 
    image: vvrf/qbittorrent:latest
    container_name: qbittorrent
    restart: unless-stopped
    environment: 
      - WEBUI_PORT=80
      - ALIYUNPAN_REFRESH_TOKEN=xxxxxxxxxx
    ports: 
      - 6881:6881
      - 6881:6881/udp
      - 80:80
    environment: 
      - /qbittorrent/downloads:/downloads
      - /qbittorrent/config:/config/qBittorrent
```

#### qbittorrent设置：
torrent完成时运行外部程序（示例）：
`aliyunpan upload "%D/%N" "/%L/%N"`
解释：下载完成后自动将文件/文件夹上传至%L(目录)下。

#### aliyunpan配置相关
详见https://github.com/tickstep/aliyunpan
