start:
	minikube start --memory 5120 --cpus=4

stop:
	minikube stop

enable-private-repo:
	./enter_regcreds.sh