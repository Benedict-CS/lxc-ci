FROM openwrt/rootfs:arm64-23.05.3

RUN opkg update && \
    opkg install python3-light python3-pip

WORKDIR /app
COPY app.py .

EXPOSE 8000

CMD ["python3", "/app/app.py"]