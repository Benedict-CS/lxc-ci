# 1. 基礎映像：
FROM zzsrv/openwrt:latest

# 2. 安裝套件：
RUN mkdir -p /var/lock && \
    opkg update && \
    opkg install python3-light python3-pip --no-check-certificate && \
    rm -rf /var/opkg-lists/* && \
    #
    # --- 關鍵修正 ---
    # 在這裡手動建立 /app 目錄，確保它一定存在
    mkdir -p /app
    # ------------------
    #

# 3. 複製您的應用程式
#    (現在 WORKDIR 會使用上面剛建立好的 /app 目錄)
WORKDIR /app
COPY app.py .

# 4. 開放 Port
EXPOSE 8000

# 5. 啟動指令
CMD ["python3", "/app/app.py"]