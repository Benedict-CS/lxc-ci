FROM zzsrv/openwrt:aarch64

RUN mkdir -p /var/lock

CMD ["/sbin/init"]