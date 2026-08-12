FROM postgres:18.4-alpine3.24

LABEL maintainer="a little <little@autre.cn> https://coding.autre.cn"

ARG PGVECTOR_VERSION=0.8.6

WORKDIR /tmp

RUN set -x \
    # && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk update \
    && apk add --no-cache tzdata git build-base clang19 llvm19 \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && git clone --branch v${PGVECTOR_VERSION} https://github.com/pgvector/pgvector.git \
    && cd pgvector \
    && make OPTFLAGS="" \
    && make install \
    && cd /tmp \
    && rm -rf /tmp/pgvector \
    && apk del tzdata git build-base clang19 llvm19 \
    && rm -rf /var/cache/apk/*

RUN set -x \
    && apk add --no-cache supervisor
