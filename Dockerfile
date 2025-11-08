# 1. 從一個空白映像開始 (如同文件中的 "FROM scratch")
FROM scratch

# 2. 下載並解壓縮 arm64 (aarch64) 的 rootfs 壓縮檔
#    (這取代了 "FROM openwrt/openwrt")
ADD https://downloads.openwrt.org/releases/23.05.3/targets/aarch64_cortex-a72/generic/openwrt-23.05.3-aarch64_cortex-a72-generic-rootfs.tar.gz /

# 3. 執行安裝 (如同文件範例，我們先建立 opkg 需要的 lock 目錄)
RUN mkdir -p /var/lock && \
    opkg update && \
    opkg install python3-light python3-pip

# 4. 複製您的程式碼
WORKDIR /app
COPY app.py .

# 5. (可選) 開放 Port
EXPOSE 8000

# 6. 您的啟動指令
CMD ["python3", "/app/app.py"]