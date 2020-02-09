#!/usr/bin/env bash

export VAULT_SA_NAME=$(kubectl get sa local-vault -o jsonpath="{.secrets[*]['name']}")
export SA_JWT_TOKEN=$(kubectl get secret $VAULT_SA_NAME -o jsonpath="{.data.token}" | base64 --decode; echo)
export SA_CA_CRT=$(kubectl get secret $VAULT_SA_NAME -o jsonpath="{.data['ca\.crt']}" | base64 --decode; echo)
export K8S_HOST=$(minikube ip)

kubectl create configmap kubernetes-auth-config \
  --from-literal sa.jwt.token="${SA_JWT_TOKEN}" \
  --from-literal k8s.host="${K8S_HOST}" \
  --from-literal ca.crt="${SA_CA_CRT}"
