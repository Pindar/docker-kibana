docker-kibana
=============

Kibana 4.0.2 running in a docker container. You can easily change the endpoint of elasticsearch via an environment variable.
To save bandwidth and disk space this image uses an alpine linux.

Usage:

```
docker run \
--name kibana \
-e ELASTICSEARCH_ENDPOINT=http://elasticsearch_client.staging.example.local:9200 \
-p 5601:5601 \
pindar/kibana
```
