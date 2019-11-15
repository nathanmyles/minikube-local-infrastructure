start:
	minikube start --memory 5120 --cpus=4

stop:
	minikube stop

enable-private-repo:
	./enter_regcreds.sh

up: cassandra-up

down: cassandra-down

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

