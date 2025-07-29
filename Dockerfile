FROM debian:bullseye-slim

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y python3 python3-pip && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY app.py .

EXPOSE 8000

CMD ["python3", "/app/app.py"]