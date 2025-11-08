# 1. 修正：使用官方、穩定、多架構的 "openwrt/openwrt" 倉庫
#    (這將會正確拉取 linux/arm64 版本)
FROM openwrt/openwrt:23.05.3

# 2. 您的 RUN 指令已經是正確的
#    (建立 lock 目錄、更新、安裝、清除)
RUN mkdir -p /var/lock && \
    opkg update && \
    opkg install python3-light python3-pip --no-check-certificate && \
    rm -rf /tmp/* /var/opkg-lists/*

# --- 以下不變 ---
WORKDIR /app
COPY app.py .

EXPOSE 8000

CMD ["python3", "/app/app.py"]