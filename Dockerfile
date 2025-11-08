# 1. 基礎映像 (你這行是正確的)
FROM openwrt/rootfs:armvirt-64-openwrt-23.05

# 2. 修改 RUN 指令
RUN \
    # 建立 opkg 需要的鎖定目錄
    mkdir -p /var/lock && \
    \
    # 現在執行 opkg update 才會成功
    opkg update && \
    \
    # 安裝你需要的軟體
    opkg install python3-light python3-pip --no-check-certificate && \
    \
    # 最佳實踐：清除 opkg 快取和下載的列表，保持映像乾淨
    rm -rf /tmp/* /var/opkg-lists/*

# 3. 剩下的部分都一樣
WORKDIR /app
COPY app.py .

EXPOSE 8000

CMD ["python3", "/app/app.py"]