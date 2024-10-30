FROM postgres:16.4-alpine3.20

LABEL maintainer="a little <little@autre.cn> https://coding.autre.cn"

ARG PGVECTOR_VERSION=0.7.4

# COPY v0.5.1.tar.gz /tmp/pgvector/

WORKDIR /tmp

RUN set -x \
    # && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
	&& apk update \
	&& apk upgrade \
	&& apk add --no-cache tzdata git build-base \
	&& cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
	&& git clone --branch v${PGVECTOR_VERSION} https://github.com/pgvector/pgvector.git \
	&& cd pgvector \
	&& make \
	&& make OPTFLAGS="" \
	&& make install \
	&& rm -r /tmp/pgvector \
	&& apk del tzdata git build-base  \
	&& rm -rf /var/lib/apt/lists/*

RUN set -x \
	&& apk add --no-cache supervisor