FROM zzsrv/openwrt:aarch64

RUN \
    # 建立 opkg 需要的 lock 目錄 (修復 opkg lock 錯誤)
    mkdir -p /var/lock && \
    \
    # 建立 /app 目錄 (修復 Cthulhu/LXC 找不到 WORKDIR 的錯誤)
    mkdir -p /app && \
    \
    # 執行 opkg update (穩定版標籤會指向 "正確的" 軟體源)
    opkg update && \
    \
    # 安裝 python
    opkg install python3-light python3-pip --no-check-certificate && \
    \
    # [!!] 修復 "Resource busy" 錯誤
    # 我們只清理 opkg 列表，"不要" 清理 /tmp/*
    rm -rf /var/opkg-lists/*

CMD ["/bin/ash"]