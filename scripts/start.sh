#!/bin/bash -e


sed -i "s/elasticsearch_url: \"http:\/\/localhost:9200\"/elasticsearch_url: \"$(echo $ELASTICSEARCH_ENDPOINT | sed -e 's/[]\/$*.^|[]/\\&/g')\"/" /kibana-4.0.0-linux-x64/config/kibana.yml

if ! [[ $USER == "" && $PASS == "" ]]; then
	echo "kibana_elasticsearch_username: $USER" >> /kibana-4.0.0-linux-x64/config/kibana.yml
	echo "kibana_elasticsearch_password: $PASS" >> /kibana-4.0.0-linux-x64/config/kibana.yml
fi


exec /kibana-4.0.0-linux-x64/bin/kibana