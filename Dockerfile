# 1. 基礎映像：
#    使用 'zzsrv/openwrt:latest' (這個版本已證明 opkg 可以運作)
FROM zzsrv/openwrt:aarch64

# 2. 安裝套件：
RUN \
    # 建立 opkg 需要的 lock 目錄
    mkdir -p /var/lock && \
    \
    # (重要！) 明確地建立你的工作目錄
    mkdir -p /app && \
    \
    # 執行 opkg update 和 install
    opkg update && \
    opkg install python3-light python3-pip --no-check-certificate && \
    \
    # 清理 opkg 列表
    rm -rf /var/opkg-lists/*

# 3. 複製您的應用程式
WORKDIR /app
COPY app.py .

# 4. 開放 Port
EXPOSE 8000

# 5. 啟動指令
CMD ["python3", "/app/app.py"]