FROM alpine:3.14.1
#RUN adduser -S -D -H -h /xmrig mining

RUN apk --no-cache upgrade && \
    apk --no-cache add git make cmake libstdc++ gcc g++ libuv-dev openssl-dev hwloc-dev kmod && \
    git clone -b v6.14.1 --depth 1 https://github.com/xmrig/xmrig.git && \
    cd xmrig && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make -j$(nproc)

WORKDIR /xmrig
COPY config.json ./build/config.json
ENTRYPOINT ["./build/xmrig"]