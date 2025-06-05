FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Cài gói và cleanup
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        python3 \
        python3-uvloop \
        python3-cryptography \
        python3-socks \
        libcap2-bin \
        ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Cấp quyền bind port <1024 cho python3
RUN setcap cap_net_bind_service=+ep $(readlink -f $(which python3))

# Tạo user tgproxy
RUN useradd -m -u 10000 tgproxy

# Chuyển quyền cho thư mục
WORKDIR /home/tgproxy
COPY --chown=tgproxy:tgproxy mtprotoproxy.py config.py ./

# Chạy với quyền user thường
USER tgproxy

CMD ["python3", "mtprotoproxy.py"]
