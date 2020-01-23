start:
	minikube start --memory 8192 --cpus=4 --vm-driver virtualbox

stop:
	minikube stop

delete:
	minikube delete

delete-persistent-volume-claims:
	kubectl delete pvc --all

restart: down up

restart-clean-data: down delete-persistent-volume-claims up

enable-private-repo:
	./enter_regcreds.sh

up: storage-up vault-up cassandra-up zookeeper-up kafka-up schema-registry-up elasticsearch-up

down: elasticsearch-down schema-registry-down kafka-down zookeeper-down cassandra-down vault-down storage-down

## Storage
storage-up:
	kubectl apply -f storage/storage.yaml

storage-down:
	kubectl delete -f storage/storage.yaml
## Storage end

## Cassandra
cassandra-up: cassandra-configmap-up cassandra-service-up cassandra-statefulset-up

cassandra-configmap-up:
	kubectl create configmap cassandra-config --from-file=cassandra/config/

cassandra-service-up:
	kubectl apply -f cassandra/service.yaml

cassandra-statefulset-up:
	kubectl apply -f cassandra/statefulset.yaml

cassandra-down: cassandra-service-down cassandra-statefulset-down cassandra-configmap-down

cassandra-configmap-down:
	kubectl delete configmap cassandra-config

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

## Vault
vault-up: vault-service-up vault-statefulset-up vault-serviceaccount-up vault-configure-kubernetes-auth
vault-service-up:
	kubectl apply -f vault/service.yaml

vault-statefulset-up:
	kubectl apply -f vault/statefulset.yaml

vault-serviceaccount-up:
	kubectl apply -f vault/service-account.yaml

vault-configure-kubernetes-auth:
	kubectl apply -f vault/kubernetes-auth/cluster-binding.yaml
	./vault/kubernetes-auth/create-configmap.sh
	kubectl apply -f vault/kubernetes-auth/configure-job.yaml

vault-down: vault-service-down vault-statefulset-down vault-serviceaccount-down vault-disable-kubernetes-auth

vault-service-down:
	kubectl delete -f vault/service.yaml

vault-statefulset-down:
	kubectl delete -f vault/statefulset.yaml

vault-serviceaccount-down:
	kubectl delete -f vault/service-account.yaml

vault-disable-kubernetes-auth:
	kubectl delete -f vault/kubernetes-auth/configure-job.yaml
	kubectl delete configmap kubernetes-auth-config
	kubectl delete -f vault/kubernetes-auth/cluster-binding.yaml
## Vault end

## ElasticSearch
elasticsearch-up: elasticsearch-service-up elasticsearch-statefulset-up

elasticsearch-service-up:
	kubectl apply -f elasticsearch/service.yaml

elasticsearch-statefulset-up:
	kubectl apply -f elasticsearch/statefulset.yaml

elasticsearch-down: elasticsearch-service-down elasticsearch-statefulset-down

elasticsearch-service-down:
	kubectl delete -f elasticsearch/service.yaml

elasticsearch-statefulset-down:
	kubectl delete -f elasticsearch/statefulset.yaml
## ElasticSearch end
