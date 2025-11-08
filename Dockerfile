# 1. 基礎映像：
#    使用 'openwrt/openwrt' 倉庫 (有 'linux/arm64' 版本)
FROM openwrt/rootfs:latest

# 2. 安裝套件：
#    - 建立 opkg 需要的 lock 目錄
#    - 執行 opkg 指令
RUN mkdir -p /var/lock && \
    opkg update && \
    opkg install python3-light python3-pip --no-check-certificate && \
    rm -rf /tmp/* /var/opkg-lists/*

# 3. 複製您的應用程式
WORKDIR /app
COPY app.py .

# 4. 開放 Port
EXPOSE 8000

# 5. 啟動指令
CMD ["python3", "/app/app.py"]