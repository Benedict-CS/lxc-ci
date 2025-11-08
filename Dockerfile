# 1. 基礎映像 (錯誤標籤)
# FROM openwrt/rootfs:armvirt-64-openwrt-23.05
#
# 1. 基礎映像 (正確標籤：使用 23.05.3 的 'v' 版本)
FROM openwrt/rootfs:armvirt-64-v23.05.3

# 2. RUN 指令 (和之前一樣，mkdir 仍然是必要的)
RUN \
    # 建立 opkg 需要的鎖定目錄
    mkdir -p /var/lock && \
    \
    # 執行 opkg update (現在會指向 23.05.3 穩定版軟體源)
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