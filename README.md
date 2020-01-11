# kube-infrastructure-starter

Base infrastructure project for kubernetes. Can be used for local development when 
working in a kubernetes environment. Allows you to stand up infrastructure components 
so you can deploy your services into the cluster for testing locally.

## Support Services

- Cassandra (available at: cassandra-0.cassandra.default.svc.cluster.local:9042)
- Zookeeper (available at: zookeeper-0.zookeeper.default.svc.cluster.local:2181)
- Kafka (available at: kafka-0.kafka.default.svc.cluster.local:9092)
- Schema Registry (available at: http://local-schema-registry.default.svc.cluster.local:8081)
- Vault (available at: http://vault-0.vault.default.svc.cluster.local:8200)
- ElasticSearch (available at: http://elasticsearch-0.elasticsearch.default.svc.cluster.local:9200)

## Prerequisites

- Minikube - https://kubernetes.io/docs/tasks/tools/install-minikube/

## Workflow

- Start minikube `make start`

- Start services: `make up`

- Restart all services: `make restart`

- Restart all services and delete all data: `make restart-clean-data`

- Stop services: `make down`

- Stop minikube `make stop`

More commands in the [Makefile](Makefile)

## Export minikube docker environment

Use this command: `eval $(minikube docker-env)`

This will allow minikube to have access to the images you build by using it's docker instance.
You need to run it in each shell you are building containers in.

## Pull images from a private repo

Use this command: `make enable-private-repo`

Minikube supports pulling images from several different container registries. If you are pulling 
from an unsupported registry, then you can use the `make enable-private-repo` command to allow 
minikube to pull images from it. This will registry a kubernetes secret that you can pull in your
manifests to allow access to your private registry.

Example of using the secret in a manifest:
```yaml
spec:
  template:
    spec:
      imagePullSecrets:
        - name: ${secret_name}
```
