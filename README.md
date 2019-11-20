# kube-infrastructure-starter

Base infrastructure project for kubernetes. Can be used for local development when 
working in a kubernetes environment. Allows you to stand up infrastructure components 
so you can deploy your services into the cluster for testing locally.

## Support Services

- Cassandra (available at: cassandra-0.cassandra.default.svc.cluster.local:9042)
- Zookeeper (available at: zookeeper-0.zookeeper.default.svc.cluster.local:2181)
- Kafka (available at: kafka-0.kafka.default.svc.cluster.local:9092)
- Schema Registry (available at: http://local-schema-registry.default.svc.cluster.local:8081)

## Prerequisites

- Minikube - https://kubernetes.io/docs/tasks/tools/install-minikube/

## Workflow

- Start minikube `make start`

- Start services: `make up`

- Stop services: `make down`

- Stop minikube `make stop`

More commands in the [Makefile](Makefile)

