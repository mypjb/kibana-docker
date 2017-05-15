# kibana-docker
this is a kibana docker project
start:
docker run --name kibana -p 5601:5601 -e ES_URL="http://es.net" -dit mypjb/kibana
