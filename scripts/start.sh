#!/bin/bash -e


sed -i "s/elasticsearch: \"http:\/\/localhost:9200\"/elasticsearch: \"$(echo $ELASTICSEARCH_ENDPOINT | sed -e 's/[]\/$*.^|[]/\\&/g')\"/" /kibana-4.0.0-beta3/config/kibana.yml

if ! [[ $USER == "" -a $PASS == ""]]; then
	echo "elasticsearch_username: $USER" >> /kibana-4.0.0-beta3/config/kibana.yml
	echo "elasticsearch_password: $PASS" >> /kibana-4.0.0-beta3/config/kibana.yml
fi


exec /kibana-4.0.0-beta3/bin/kibana