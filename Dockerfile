FROM zzsrv/openwrt:aarch64

RUN mkdir -p /var/lock

WORKDIR /app
COPY app.py .

EXPOSE 8000

CMD ["/bin/ash"]