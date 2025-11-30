FROM alpine:3.19

RUN apk update
RUn apk add python3

CMD ["/bin/sh"]

# alpine:3.19
# ubuntu:25.04
# debian:unstable-20251117-slim
# ymirwang/prplos:v2.33 


