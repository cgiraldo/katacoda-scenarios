Finally we are going to dockerize a software from source code
.  

Again, we set the docker reference image to Alpine Linux.

<pre class="file" data-filename="Dockerfile" data-target="replace">FROM alpine:3.8
LABEL maintainer="cgiraldo@gradiant.org"
LABEL organization="gradiant.org"
</pre>

We must set instructions to:
 
Get build tools and build dependencies:

<pre class="file" data-filename="Dockerfile" data-target="append">
ENV SQUID_VERSION=3.5.28

RUN apk add --no-cache bash \
                     build-base \
                     curl \
                     libnetfilter_conntrack \
                     libnfnetlink-dev \
                     linux-headers \
                     openssl openssl-dev \
                     perl</pre>
                     
Get the source code:
<pre class="file" data-filename="Dockerfile" data-target="append">
RUN mkdir -p /opt && cd /opt && curl http://www.squid-cache.org/Versions/v3/3.5/squid-$SQUID_VERSION.tar.gz | tar -xvz
RUN adduser squid squid
</pre>

And build the software:

<pre class="file" data-filename="Dockerfile" data-target="append">
RUN cd /opt/squid-$SQUID_VERSION && ./configure --prefix=/usr/local/squid --with-openssl
RUN cd /opt/squid-$SQUID_VERSION && make
RUN cd /opt/squid-$SQUID_VERSION && make install
</pre>

Then add a custom entrypoint.sh initialize cache if not already done and launch squid in foreground.

<pre class="file" data-filename="Dockerfile" data-target="append">
COPY start_squid.sh /usr/local/squid/bin/start_squid.sh
RUN cd /usr/local/ && tar -cvzf /squid-bin.tgz .
VOLUME ["/usr/local/squid/var"]
EXPOSE 3128
ENTRYPOINT ["/usr/local/squid/bin/start_squid.sh"]
CMD ["-d 8"]
</pre>

Wow, that's a lot of instructions, layers and non-useful files to run squid (build-tools etc.)
Let's follow the next best-practice recommendation:

>Multi-stage builds (in Docker 17.05 or higher) allow you to drastically reduce the size of your final image,
 without struggling to reduce the number of intermediate layers and files.

<pre class="file" data-filename="Dockerfile" data-target="replace">
FROM alpine:3.8 as builder

LABEL maintainer="cgiraldo@gradiant.org"
LABEL organization="gradiant.org"

ENV SQUID_VERSION=3.5.28

RUN apk add --no-cache bash \
                     build-base \
                     curl \
                     libnetfilter_conntrack \
                     libnfnetlink-dev \
                     linux-headers \
                     openssl openssl-dev \
                     perl
RUN mkdir -p /opt && cd /opt && curl http://www.squid-cache.org/Versions/v3/3.5/squid-$SQUID_VERSION.tar.gz | tar -xvz
RUN adduser squid squid
RUN cd /opt/squid-$SQUID_VERSION && ./configure --prefix=/usr/local/squid --with-openssl

RUN cd /opt/squid-$SQUID_VERSION && make
RUN cd /opt/squid-$SQUID_VERSION && make install
COPY start_squid.sh /usr/local/squid/bin/start_squid.sh
RUN cd /usr/local/ && tar -cvzf /squid-bin.tgz .

FROM  alpine:3.8
LABEL maintainer="cgiraldo@gradiant.org"
LABEL organization="gradiant.org"

ENV SQUID_VERSION=3.5.28

COPY --from=builder /squid-bin.tgz /usr/local/
RUN apk add --no-cache libstdc++ openssl && \
    cd /usr/local && tar -xvzf squid-bin.tgz

VOLUME ["/usr/local/squid/var"]
EXPOSE 3128

ENTRYPOINT ["/usr/local/squid/bin/start_squid.sh"]
CMD ["-d 8"]
</pre>

Our final image now is two-layer and It only has squid binaries and running dependencies!
 
`build -t squid .`{{execute}}

You can try to build the image, but you must be patient. 
The first stage that compiles from source take a lot of time!

Another advantage of multistage Dockerfiles is that take advantage of caching layers.
You don't need to rebuild the first stage (here is compiling sources) if you modify instructions of the next stages.
