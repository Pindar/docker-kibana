#!/bin/bash -e


sed -i "s/elasticsearch_url: \"http:\/\/localhost:9200\"/elasticsearch_url: \"$(echo $ELASTICSEARCH_ENDPOINT | sed -e 's/[]\/$*.^|[]/\\&/g')\"/" /kibana-${KIBANA_VERSION}-linux-x64/config/kibana.yml

if ! [[ $USER == "" && $PASS == "" ]]; then
	echo "kibana_elasticsearch_username: $USER" >> /kibana-${KIBANA_VERSION}-linux-x64/config/kibana.yml
	echo "kibana_elasticsearch_password: $PASS" >> /kibana-${KIBANA_VERSION}-linux-x64/config/kibana.yml
fi


exec /kibana-${KIBANA_VERSION}-linux-x64/bin/kibana