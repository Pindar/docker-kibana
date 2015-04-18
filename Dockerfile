FROM gliderlabs/alpine
MAINTAINER Simon Dittlmann

RUN apk-install bash curl tar gzip

ENV KIBANA_VERSION 4.0.2
RUN curl -L -O https://download.elastic.co/kibana/kibana/kibana-${KIBANA_VERSION}-linux-x64.tar.gz && \
	tar xfv kibana-${KIBANA_VERSION}-linux-x64.tar.gz -C / && \
  rm /kibana-4.0.2-linux-x64/node/bin/node && \
  rm /kibana-4.0.2-linux-x64/node/bin/npm

# install node for alpine
ENV VERSION=v1.7.1 CMD=iojs DOMAIN=iojs.org

RUN apk update && \
  apk add make gcc g++ python paxctl curl && \
  curl -sSL https://${DOMAIN}/dist/${VERSION}/${CMD}-${VERSION}.tar.gz | tar -xz && \
  cd /${CMD}-${VERSION} && \
  NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \
  export CFLAGS="$CFLAGS -D__USE_MISC" && \
  ./configure --prefix=/usr && \
  make -j${NPROC} -C out mksnapshot && \
  paxctl -c -m out/Release/mksnapshot && \
  make -j${NPROC} && \
  make install && \
  paxctl -cm /usr/bin/${CMD} && \
  apk del make gcc g++ python paxctl curl && \
  apk add libgcc libstdc++ && \
  cd / && \
  rm -rf /${CMD}-${VERSION} /var/cache/apk/* /tmp/* /root/.npm \
    /usr/lib/node_modules/npm/man /usr/lib/node_modules/npm/doc /usr/lib/node_modules/npm/html

RUN ln -s /usr/bin/node /kibana-4.0.2-linux-x64/node/bin/node && \
  ln -s /usr/bin/npm /kibana-4.0.2-linux-x64/node/bin/npm

ADD scripts/start.sh /start.sh
RUN chmod +x /start.sh
CMD ["/start.sh"]

EXPOSE 5601