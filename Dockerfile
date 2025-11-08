FROM dickhub/openwrt:arm64

RUN opkg update 

CMD ["/bin/ash"]