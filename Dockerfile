FROM ubuntu:14.04
MAINTAINER Simon Dittlmann


RUN apt-get update -y -qq && \
	apt-get install -y -qq curl tar

RUN curl http://nginx.org/keys/nginx_signing.key | apt-key add - && \
	echo "deb http://nginx.org/packages/mainline/ubuntu/ trusty nginx" > /etc/apt/sources.list.d/nginx.list && \
	echo "deb-src http://nginx.org/packages/mainline/ubuntu/ trusty nginx" >> /etc/apt/sources.list.d/nginx.list && \
	apt-get update -qq && \
	apt-get install -y -qq nginx && \
	apt-get -y clean

RUN curl -L -O https://download.elasticsearch.org/kibana/kibana/kibana-3.1.2.tar.gz && \
	tar xfv kibana-3.1.2.tar.gz -C /usr/share/nginx/html

RUN echo "daemon off;" >> /etc/nginx/nginx.conf

ADD conf/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf

ADD scripts/start.sh /start.sh
RUN chmod +x /start.sh
CMD ["/start.sh"]

EXPOSE 80