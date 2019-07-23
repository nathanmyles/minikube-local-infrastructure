#!/usr/bin/env bash

set -e

read -p "Secret name URL: " name
read -p "Registry URL: " registry_url
read -p "Email: " email
read -p "Username [${email}]: " username
username="${username:-${email}}"
read -p "Password: " -s password

echo "kubectl create secret docker-registry ${name}
    --docker-server=${registry_url}
    --docker-password=********
    --docker-email=${email}
    --docker-username=${username}"

kubectl create secret docker-registry ${name} \
    --docker-server="${registry_url}" \
    --docker-password="${password}" \
    --docker-email="${email}" \
    --docker-username="${username}"

echo "Add this to pull a container from the repo:
spec:
  template:
    spec:
      imagePullSecrets:
        - name: ${name}"