FROM ubuntu:14.04
MAINTAINER Simon Dittlmann


RUN apt-get update -y -qq && \
	apt-get install -y -qq curl tar

RUN curl -L -O https://download.elasticsearch.org/kibana/kibana/kibana-4.0.0-linux-x64.tar.gz && \
	tar xfv kibana-4.0.0-linux-x64.tar.gz -C /

ENV JAVA_VERSION 8u25
ENV JAVA_FOLDER_NAME jdk1.8.0_25
RUN apt-get update -qq && \
	apt-get install -y wget gzip && \
	cd /tmp && wget --no-cookies --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com; oraclelicense=accept-securebackup-cookie; s_nr=1394181036342;" http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}-b17/jdk-${JAVA_VERSION}-linux-x64.tar.gz && \
	gzip -d jdk-${JAVA_VERSION}-linux-x64.tar.gz && \
	tar -xf jdk-${JAVA_VERSION}-linux-x64.tar && \
	mkdir -p /opt/Oracle_Java && \
	mv /tmp/${JAVA_FOLDER_NAME} /opt/Oracle_Java/${JAVA_FOLDER_NAME} && \
	sudo update-alternatives --install "/usr/bin/java" "java" "/opt/Oracle_Java/${JAVA_FOLDER_NAME}/bin/java" 1 && \
	sudo update-alternatives --install "/usr/bin/javac" "javac" "/opt/Oracle_Java/${JAVA_FOLDER_NAME}/bin/javac" 1 && \
	sudo update-alternatives --install "/usr/bin/javaws" "javaws" "/opt/Oracle_Java/${JAVA_FOLDER_NAME}/bin/javaws" 1 && \
	sudo update-alternatives --install "/usr/bin/jar" "jar" "/opt/Oracle_Java/${JAVA_FOLDER_NAME}/bin/jar" 1 && \
	sudo update-alternatives --set "java" "/opt/Oracle_Java/${JAVA_FOLDER_NAME}/bin/java" && \
	sudo update-alternatives --set "javac" "/opt/Oracle_Java/${JAVA_FOLDER_NAME}/bin/javac" && \
	sudo update-alternatives --set "javaws" "/opt/Oracle_Java/${JAVA_FOLDER_NAME}/bin/javaws" && \
	sudo update-alternatives --set "jar" "/opt/Oracle_Java/${JAVA_FOLDER_NAME}/bin/jar" && \
	rm -rf /tmp/jdk-${JAVA_VERSION}-linux-x64.tar

ADD scripts/start.sh /start.sh
RUN chmod +x /start.sh
CMD ["/start.sh"]

EXPOSE 5601