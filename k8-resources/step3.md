Alpine linux se basa en musl libc y busybox. musl y glibc son dos implementaciones de la librería "libc". Puede que 

ENVSUBST

JINJA

FROM alpine:3.8 as builder

MAINTAINER cgiraldo
ENV SQUID_VERSION=3.5.20
RUN apk --update add curl build-base perl openssl openssl-dev libnetfilter_conntrack libnfnetlink-dev linux-headers bash
RUN mkdir -p /opt && cd /opt && curl http://www.squid-cache.org/Versions/v3/3.5/squid-$SQUID_VERSION.tar.gz | tar -xvz && adduser squid squid && \
    cd /opt/squid-$SQUID_VERSION && ./configure --prefix=/usr/local/squid --enable-icap-client \
                                        --enable-loadable-modules \
                                        --with-openssl \
                                        --enable-ssl-crtd \
                                        --enable-silent-rules \
                                        --enable-dependency-tracking \
                                        --enable-icmp \
                                        --enable-delay-pools \
                                        --enable-useragent-log \
                                        --enable-esi \
                                        --enable-follow-x-forwarded-for \
                                        --enable-linux-netfilter \
                                        --enable-auth PKG_CONFIG_PATH=/usr/local/lib/pkgconfig && \
    make && make install && apk del curl perl && rm -r /opt/squid-*

VOLUME ["/usr/local/squid/var"]

COPY start_squid.sh /usr/local/bin/start_squid.sh

ENTRYPOINT ["/usr/local/bin/start_squid.sh"]