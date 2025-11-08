FROM registry.gitlab.com/prplos/alpine3.16-arm32v7:latest

WORKDIR /app
COPY app.py .

EXPOSE 8000

CMD ["python3", "/app/app.py"]