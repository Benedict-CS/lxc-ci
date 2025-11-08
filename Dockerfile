FROM 14790897/openwrt:aarch64_generic

RUN opkg update 

CMD ["/bin/ash"]