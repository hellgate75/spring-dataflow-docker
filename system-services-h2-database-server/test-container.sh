#!/bin/sh
if [ "" != "$(docker ps -a|grep test-h2-2)" ]; then
	if [ "" != "$(docker ps -a|grep test-h2-2|grep Up)" ]; then
		docker stop test-h2-2
	fi
	docker rm -f test-h2-2
	docker volume prune -f
fi
docker run  -d --tty --rm -v h2_data_volume:/var/h2-database/data -p 9081:9090 -p 65123:65123 -e "H2_ENABLE_WEB=true" -e "H2_ENABLE_INSECURE=true" -e "H2_ENABLE_SECURE=false" -e "H2_DATA_GIT_URL=git@github.com:hellgate75/dataflow-flow-centric-config.git|/data" --name test-h2-2 hellgate75/h2-database:2019.10.14
echo "type: docker logs -f test-h2-2 if you need details on this container"
