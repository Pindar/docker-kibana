#!/bin/bash -e


sed -i "s/http:\/\/\"+window.location.hostname+\":9200/http:\/\/\"+window.location.hostname+\"/" /usr/share/nginx/html/kibana-3.1.2/config.js
sed -i "s/<ELASTICSEARCH_ENDPOINT>/$(echo $ELASTICSEARCH_ENDPOINT | sed -e 's/[]\/$*.^|[]/\\&/g')/" /etc/nginx/conf.d/default.conf

exec /usr/sbin/nginx