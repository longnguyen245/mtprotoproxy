# Không dùng USER tgproxy
# Không dùng setcap
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        python3 \
        python3-uvloop \
        python3-cryptography \
        python3-socks \
        ca-certificates && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY mtprotoproxy.py config.py ./

CMD ["python3", "mtprotoproxy.py"]
