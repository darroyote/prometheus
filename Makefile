.PHONY: run-node-exporter
run-node-exporter:
	docker run --rm -p 9100:9100 --name=node-exporter quay.io/prometheus/node-exporter

.PHONY: run-cadvisor
run-cadvisor:
	sudo docker run --rm -v /:/rootfs:ro -v /var/run:/var/run:ro -v /sys:/sys:ro -v /var/lib/docker:/var/lib/docker:ro -v /dev/disk:/dev/disk:ro -p 8080:8080 --name=cadvisor google/cadvisor:latest

.PHONY: run-grafana
run-grafana:
	docker run --rm -p 3000:3000 --name=grafana grafana/grafana:6.4.4

.PHONY: run-prometheus
run-prometheus:
	docker run --rm -p 9090:9090 -v $(shell pwd)/prometheus/:/prom/ --name prometheus prom/prometheus --config.file=/prom/config.yaml

.PHONY: run-alertmanager
run-alertmanager:
	docker run --rm -p 9090:9090 -v $(shell pwd)/prometheus/:/prom/ --name prometheus prom/prometheus --config.file=/prom/config.yaml

.PHONY: run-prometheus-and-alertmanager
run-prometheus-and-alertmanager:
	docker-compose up

