FROM debian:buster AS builder

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential git wget curl ca-certificates && \
    git clone https://gitlab.com/akihe/radamsa.git && \
    cd radamsa && \
    make && \
    rm -rf /var/lib/apt/lists/*


FROM debian:buster

RUN apt-get update && \
    apt-get install -y haproxy && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /radamsa/bin/radamsa /usr/bin/radamsa
COPY haproxy.cfg /etc/haproxy/haproxy.cfg
COPY start.sh /start.sh

EXPOSE 8888

CMD ["/start.sh"]
