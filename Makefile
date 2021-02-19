start:
	minikube start --memory 8192 --cpus=4

stop:
	minikube stop

delete-cluster:
	minikube delete

delete-persistent-volumes:
	kubectl delete pvc --all
	kubectl delete pv --all

restart: down up

restart-clean-data: down delete-persistent-volumes up

enable-private-repo:
	./enter_regcreds.sh

up: storage-up vault-up cassandra-up zookeeper-up kafka-up schema-registry-up elasticsearch-up

down: elasticsearch-down schema-registry-down kafka-down zookeeper-down cassandra-down vault-down storage-down

## Storage
storage-up:
	-kubectl apply -f storage/storage.yaml

storage-down:
	-kubectl delete -f storage/storage.yaml
## Storage end

## Cassandra
cassandra-up: cassandra-configmap-up cassandra-service-account-up cassandra-configure-vault cassandra-service-up cassandra-statefulset-up

cassandra-configmap-up:
	-kubectl create configmap cassandra-config --from-file=cassandra/config/

cassandra-configure-vault:
	-kubectl apply -f cassandra/pki/configure-vault.yaml

cassandra-service-up:
	-kubectl apply -f cassandra/service.yaml

cassandra-statefulset-up:
	-kubectl apply -f cassandra/statefulset.yaml

cassandra-service-account-up:
	-kubectl apply -f cassandra/service-account.yaml

cassandra-down: cassandra-service-down cassandra-statefulset-down cassandra-service-account-down cassandra-configmap-down cassandra-cleanup-configure-vault-job

cassandra-configmap-down:
	-kubectl delete configmap cassandra-config

cassandra-cleanup-configure-vault-job:
	-kubectl delete -f cassandra/pki/configure-vault.yaml

cassandra-service-down:
	-kubectl delete -f cassandra/service.yaml

cassandra-statefulset-down:
	-kubectl delete -f cassandra/statefulset.yaml

cassandra-service-account-down:
	-kubectl delete -f cassandra/service-account.yaml
## Cassandra end

## Zookeeper
zookeeper-up: zookeeper-service-up zookeeper-statefulset-up

zookeeper-service-up:
	-kubectl apply -f zookeeper/service.yaml

zookeeper-statefulset-up:
	-kubectl apply -f zookeeper/statefulset.yaml

zookeeper-down: zookeeper-service-down zookeeper-statefulset-down

zookeeper-service-down:
	-kubectl delete -f zookeeper/service.yaml

zookeeper-statefulset-down:
	-kubectl delete -f zookeeper/statefulset.yaml
## Zookeeper end

## Kafka
kafka-up: kafka-configmap-up kafka-configure-pki kafka-service-up kafka-statefulset-up

kafka-configmap-up:
	-kubectl create configmap kafka-config --from-file=kafka/config/

kafka-configure-pki:
	-kubectl apply -f kafka/pki/configure-pki-job.yaml

kafka-service-up:
	-kubectl apply -f kafka/service.yaml

kafka-statefulset-up:
	-kubectl apply -f kafka/statefulset.yaml

kafka-down: kafka-service-down kafka-statefulset-down kafka-cleanup-configure-pki-job kafka-configmap-down

kafka-configmap-down:
	-kubectl delete configmap kafka-config

kafka-service-down:
	-kubectl delete -f kafka/service.yaml

kafka-statefulset-down:
	-kubectl delete -f kafka/statefulset.yaml

kafka-cleanup-configure-pki-job:
	-kubectl delete -f kafka/pki/configure-pki-job.yaml
## Kafka end

## Schema Registry
schema-registry-up: schema-registry-configmap-up schema-registry-service-up schema-registry-deployment-up

schema-registry-configmap-up:
	-kubectl create configmap schema-registry-config --from-file=schema-registry/config/

schema-registry-service-up:
	-kubectl apply -f schema-registry/service.yaml

schema-registry-deployment-up:
	-kubectl apply -f schema-registry/deployment.yaml

schema-registry-down: schema-registry-service-down schema-registry-deployment-down schema-registry-configmap-down

schema-registry-configmap-down:
	-kubectl delete configmap schema-registry-config

schema-registry-service-down:
	-kubectl delete -f schema-registry/service.yaml

schema-registry-deployment-down:
	-kubectl delete -f schema-registry/deployment.yaml
## Schema Registry end

## Vault
vault-up: vault-configmap-up vault-service-account-up vault-service-up vault-statefulset-up vault-configure-kubernetes-auth

vault-configmap-up:
	-kubectl create configmap vault-config --from-file=vault/config/

vault-service-up:
	-kubectl apply -f vault/service.yaml

vault-statefulset-up:
	-kubectl apply -f vault/statefulset.yaml

vault-service-account-up:
	-kubectl apply -f vault/service-account.yaml

vault-configure-kubernetes-auth:
	-kubectl apply -f vault/kubernetes-auth/cluster-binding.yaml
	-./vault/kubernetes-auth/create-configmap.sh
	-kubectl apply -f vault/kubernetes-auth/configure-job.yaml

vault-cleanup:
	-kubectl delete -f vault/kubernetes-auth/configure-job.yaml

vault-down: vault-configmap-down vault-service-down vault-statefulset-down vault-service-account-down vault-disable-kubernetes-auth

vault-configmap-down:
	-kubectl delete configmap vault-config

vault-service-down:
	-kubectl delete -f vault/service.yaml

vault-statefulset-down:
	-kubectl delete -f vault/statefulset.yaml

vault-service-account-down:
	-kubectl delete -f vault/service-account.yaml

vault-disable-kubernetes-auth: vault-cleanup
	-kubectl delete configmap kubernetes-auth-config
	-kubectl delete -f vault/kubernetes-auth/cluster-binding.yaml

## Vault end

## ElasticSearch
elasticsearch-up: elasticsearch-service-up elasticsearch-statefulset-up

elasticsearch-service-up:
	-kubectl apply -f elasticsearch/service.yaml

elasticsearch-statefulset-up:
	-kubectl apply -f elasticsearch/statefulset.yaml

elasticsearch-down: elasticsearch-service-down elasticsearch-statefulset-down

elasticsearch-service-down:
	-kubectl delete -f elasticsearch/service.yaml

elasticsearch-statefulset-down:
	-kubectl delete -f elasticsearch/statefulset.yaml
## ElasticSearch end
