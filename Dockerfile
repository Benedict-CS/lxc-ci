# 1. 基礎映像：
#    - 使用 openwrt/rootfs (官方映像)
#    - 使用 armvirt-64-v23.05.3 (arm64 架構的 23.05.3 "穩定版" 標籤)
FROM openwrt/rootfs:armvirt-64-v23.05.3

# 2. RUN 指令：
#    - 建立 /var/lock (修復 opkg 的 "No such file" 問題)
#    - 執行 opkg update (穩定版標籤會指向 "正確的" 軟體源)
#    - 安裝 python
#    - 清理快取
RUN \
    mkdir -p /var/lock && \
    opkg update && \
    opkg install python3-light python3-pip --no-check-certificate && \
    rm -rf /tmp/* /var/opkg-lists/*

# 3. 剩下的部分 (你的應用)
WORKDIR /app
COPY app.py .

EXPOSE 8000

CMD ["python3", "/app/app.py"]