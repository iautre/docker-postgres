FROM postgres:17.0-alpine3.20

LABEL maintainer="a little <little@autre.cn> https://coding.autre.cn"

ARG PG_MAJOR=17
ARG PGVECTOR_VERSION=0.7.4

# COPY v0.5.1.tar.gz /tmp/pgvector/

RUN set -x \
    # && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
	&& apk update \
	&& apk upgrade \
	&& apk add --no-cache tzdata wget build-base postgresql-${PG_MAJOR}-dev \
	&& cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
	&& mkdir -p /tmp/pgvector \
	&& wget https://github.com/pgvector/pgvector/archive/refs/tags/v${PGVECTOR_VERSION}.tar.gz -O /tmp/pgvector/v${PGVECTOR_VERSION}.tar.gz \
	&& tar -zxvf /tmp/pgvector/v${PGVECTOR_VERSION}.tar.gz -C /tmp/pgvector \
	&& cd /tmp/pgvector/pgvector-${PGVECTOR_VERSION} \
	&& make clean \
	&& make OPTFLAGS="" \
	&& make install \
	&& mkdir -p /usr/share/doc/pgvector \
	&& cp LICENSE README.md /usr/share/doc/pgvector \
	&& rm -r /tmp/pgvector \
	&& apk del tzdata wget build-base postgresql-${PG_MAJOR}-dev \
	&& rm -rf /var/lib/apt/lists/*

RUN set -x \
	&& apk add --no-cache supervisor