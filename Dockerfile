FROM postgres:17.5-alpine3.22

LABEL maintainer="a little <little@autre.cn> https://coding.autre.cn"

ARG PGVECTOR_VERSION=0.8.0

# COPY v0.5.1.tar.gz /tmp/pgvector/

WORKDIR /tmp

RUN set -x \
    # && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
	&& apk update \
	&& apk upgrade \
	&& apk add --no-cache tzdata git build-base clang19 llvm19 \
	&& cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
	&& echo "Asia/Shanghai" > /etc/timezone \
	&& git clone --branch v${PGVECTOR_VERSION} https://github.com/pgvector/pgvector.git \
	&& cd pgvector \
	&& make \
	&& make OPTFLAGS="" \
	&& make install \
	&& rm -r /tmp/pgvector \
	&& apk del tzdata git build-base clang19 llvm19 \
	&& rm -rf /var/lib/apt/lists/*

RUN set -x \
	&& apk add --no-cache supervisor