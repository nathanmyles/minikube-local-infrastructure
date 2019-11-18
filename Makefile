start:
	minikube start --memory 8192 --cpus=4 --vm-driver virtualbox

stop:
	minikube stop

enable-private-repo:
	./enter_regcreds.sh

up: cassandra-up zookeeper-up kafka-up

down: cassandra-down zookeeper-down kafka-down

## Cassandra
cassandra-up: cassandra-service-up cassandra-statefulset-up

cassandra-service-up:
	kubectl apply -f cassandra/service.yaml

cassandra-statefulset-up:
	kubectl apply -f cassandra/statefulset.yaml

cassandra-down: cassandra-service-down cassandra-statefulset-down

cassandra-service-down:
	kubectl delete -f cassandra/service.yaml

cassandra-statefulset-down:
	kubectl delete -f cassandra/statefulset.yaml
## Cassandra end

## Zookeeper
zookeeper-up: zookeeper-service-up zookeeper-statefulset-up

zookeeper-service-up:
	kubectl apply -f zookeeper/service.yaml

zookeeper-statefulset-up:
	kubectl apply -f zookeeper/statefulset.yaml

zookeeper-down: zookeeper-service-down zookeeper-statefulset-down

zookeeper-service-down:
	kubectl delete -f zookeeper/service.yaml

zookeeper-statefulset-down:
	kubectl delete -f zookeeper/statefulset.yaml
## Zookeeper end

## Kafka
kafka-up: kafka-service-up kafka-statefulset-up

kafka-service-up:
	kubectl apply -f kafka/service.yaml

kafka-statefulset-up:
	kubectl apply -f kafka/statefulset.yaml

kafka-down: kafka-service-down kafka-statefulset-down

kafka-service-down:
	kubectl delete -f kafka/service.yaml

kafka-statefulset-down:
	kubectl delete -f kafka/statefulset.yaml
## Kafka end

## Schema Registry
schema-registry-up: schema-registry-service-up schema-registry-deployment-up

schema-registry-service-up:
	kubectl apply -f schema-registry/service.yaml

schema-registry-deployment-up:
	kubectl apply -f schema-registry/deployment.yaml

schema-registry-down: schema-registry-service-down schema-registry-deployment-down

schema-registry-service-down:
	kubectl delete -f schema-registry/service.yaml

schema-registry-deployment-down:
	kubectl delete -f schema-registry/deployment.yaml
## Schema Registry end

