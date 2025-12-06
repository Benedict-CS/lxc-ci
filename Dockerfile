FROM ymirwang/prplos:v2.33
                     
CMD ["/bin/sh"]

# alpine:3.19 20251130-b8316b5 ci 18s cd 46
# ubuntu:25.04 20251130-43309ea ci 22s cd 46
# debian:12-slim 20251130-6b09903 ci 27s cd 46
# ymirwang/prplos:v2.33 20251130-4d30d73  ci 23s cd 46

# FROM python:3.11-alpine

# WORKDIR /app
# COPY app.py .

# EXPOSE 8000

# CMD ["python3", "/app/app.py"]