# minikube-local-infrastructure

Base infrastructure project for kubernetes. Can be used for local development when 
working in a kubernetes environment. Allows you to stand up infrastructure components 
so you can deploy your services into the cluster for testing locally.

## Support Services

- Cassandra 
    - non-TLS URL: local-cassandra-0.local-cassandra.default:9042
    - TLS URL: local-cassandra-0.local-cassandra.default:9142
- Zookeeper 
    - URL: local-zookeeper-0.local-zookeeper.default:2181
- Kafka 
    - URL: local-kafka-0.local-kafka.default:9092
- Schema Registry 
    - URL: http://local-schema-registry.default:8081
- Vault 
    - non-TLS URL: https://local-vault.default:8200
    - TLS URL: http://local-vault.default:8300
    - CA cert URL: http://local-vault.default/ca_cert.crt
    - root token: roottoken
- ElasticSearch 
    - URL: http://local-elasticsearch.default:9200

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
