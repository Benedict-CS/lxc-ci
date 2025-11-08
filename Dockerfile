FROM zzsrv/openwrt:aarch64

RUN mkdir -p /var/lock && \
    mkdir -p /app && \
    opkg update && \
    opkg install python3-light python3-pip --no-check-certificate && \
    rm -rf /var/opkg-lists/*

COPY app.py /app/app.py

EXPOSE 8000

CMD ["/sbin/init"]