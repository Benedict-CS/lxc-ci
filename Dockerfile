# 確保你使用的是 arm64 相容的 base image
FROM openwrt/rootfs:armvirt-64-openwrt-23.05

# 【修正】
# 根據 OpenWrt Docker 文件，opkg 需要 /var/lock 目錄才能運作
#
RUN mkdir -p /var/lock && \
    opkg update && \
    opkg install python3-light python3-pip --no-check-certificate

WORKDIR /app
COPY app.py .

EXPOSE 8000

CMD ["python3", "/app/app.py"]