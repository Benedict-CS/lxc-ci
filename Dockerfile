# 1. 修正：使用 'openwrt/openwrt' 倉庫 (有 'linux/arm64' 版本)
FROM openwrt/openwrt:23.05.3

# 2. 修正：在 opkg update 之前建立 /var/lock 目錄
RUN mkdir -p /var/lock && \
    opkg update && \
    opkg install python3-light python3-pip --no-check-certificate && \
    rm -rf /tmp/* /var/opkg-lists/*

# --- 以下不變 ---
WORKDIR /app
COPY app.py .

EXPOSE 8000

CMD ["python3", "/app/app.py"]