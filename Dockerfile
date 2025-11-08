# 1. 基礎映像：
#    使用官方 'openwrt/openwrt' 倉庫的多架構標籤。
#    您的 buildx 指令會自動為 'linux/arm64' 平台拉取正確的版本。
FROM openwrt/openwrt:23.05.3

# 2. 安裝套件：
#    - 立即建立 /var/lock 目錄以避免 opkg 鎖定錯誤。
#    - 保留 --no-check-certificate 以增加網路下載的穩定性。
RUN mkdir -p /var/lock && \
    opkg update && \
    opkg install python3-light python3-pip --no-check-certificate

# 3. 複製您的應用程式
WORKDIR /app
COPY app.py .

# 4. 開放 Port
EXPOSE 8000

# 5. 啟動指令
CMD ["python3", "/app/app.py"]