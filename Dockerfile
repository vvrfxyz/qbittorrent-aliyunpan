# 使用官方Ubuntu基础镜像
FROM ubuntu:23.10

# 安装必要的软件包和添加qBittorrent PPA
RUN apt-get update && apt-get install -y \
    software-properties-common \
    && add-apt-repository ppa:qbittorrent-team/qbittorrent-stable \
    && apt-get update && apt-get install -y \
    curl \
    gnupg \
    cron \
    qbittorrent-nox \
    && rm -rf /var/lib/apt/lists/*

# 安装aliyunpan
RUN curl -fsSL http://file.tickstep.com/apt/pgp | gpg --dearmor | tee /etc/apt/trusted.gpg.d/tickstep-packages-archive-keyring.gpg > /dev/null \
    && echo "deb [signed-by=/etc/apt/trusted.gpg.d/tickstep-packages-archive-keyring.gpg arch=amd64,arm64] http://file.tickstep.com/apt aliyunpan main" | tee /etc/apt/sources.list.d/tickstep-aliyunpan.list > /dev/null \
    && apt-get update \
    && apt-get install -y aliyunpan

# 设置环境变量
ENV WEBUI_PORT=80 \
    ALIYUNPAN_REFRESH_TOKEN=your_refresh_token_here 
    
COPY qBittorrent /config/qBittorrent

# 设置定时任务刷新Token
RUN (crontab -l ; echo "*/60 * * * * aliyunpan token update -mode 2") | crontab -

# 复制run.sh脚本到/usr/sbin目录下
COPY run.sh /usr/sbin/run.sh

# 使run.sh脚本可执行
RUN chmod +x /usr/sbin/run.sh

# 设置启动命令
CMD ["/usr/sbin/run.sh"]
