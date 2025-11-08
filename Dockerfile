FROM openwrt/openwrt:23.05.3

# 2. 修正：在 opkg update 前先建立 /var/lock 目錄
#    (如您找到的文件所示，這能避免 opkg 鎖定失敗)
RUN mkdir -p /var/lock && \
    opkg update && \
    opkg install python3-light python3-pip --no-check-certificate

# --- 以下不變 ---
WORKDIR /app
COPY app.py .

EXPOSE 8000

CMD ["python3", "/app/app.py"]