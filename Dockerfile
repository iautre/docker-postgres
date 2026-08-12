ARG POSTGRES_VERSION=18.4
ARG ALPINE_VERSION=3.24
ARG PGVECTOR_VERSION=0.8.6

FROM postgres:${POSTGRES_VERSION}-alpine${ALPINE_VERSION}

LABEL maintainer="a little <little@autre.cn> https://coding.autre.cn"

ARG PGVECTOR_VERSION

WORKDIR /tmp

RUN set -x \
    # && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk update \
    && apk add --no-cache tzdata git build-base clang21 llvm21 \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && git clone --branch v${PGVECTOR_VERSION} https://github.com/pgvector/pgvector.git \
    && cd pgvector \
    && make OPTFLAGS="" \
    && make install \
    && cd /tmp \
    && rm -rf /tmp/pgvector \
    && apk del tzdata git build-base clang21 llvm21 \
    && rm -rf /var/cache/apk/*

RUN set -x \
    && apk add --no-cache supervisor
