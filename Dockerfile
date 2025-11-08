# 1. 基礎映像：
#    使用 'zzsrv/openwrt:latest' (這個版本已證明 opkg 可以運作)
FROM zzsrv/openwrt:aarch64

# 2. 安裝套件：
RUN mkdir -p /var/lock && \
    opkg update && \
    opkg install python3-light python3-pip --no-check-certificate && \
    # 修正：只清理 opkg 列表，避免刪除 /tmp/resolv.conf
    rm -rf /var/opkg-lists/*
    
    mkdir -p /app

# 3. 複製您的應用程式
WORKDIR /app
COPY app.py .

# 4. 開放 Port
EXPOSE 8000

# 5. 啟動指令
CMD ["python3", "/app/app.py"]