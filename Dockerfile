FROM openwrt/rootfs:23.05.3

RUN opkg update && \
    opkg install python3-light python3-pip --no-check-certificate

WORKDIR /app
COPY app.py .

EXPOSE 8000

CMD ["python3", "/app/app.py"]