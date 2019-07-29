kubectl create -f kafka-topics.yaml
kubectl create -f kafka-users.yaml
kubectl create -f kafka-client-mm.yaml

sleep 5s

setup_kafka_client_ssl () {
  echo "Setting Up Kafka Client for SSL"
  kubectl cp ./setup_ssl.sh "kafka/mm-kafkaclient:/opt/kafka/setup_ssl.sh"
  kubectl exec -n kafka -it "mm-kafkaclient" -- bash setup_ssl.sh
}

setup_kafka_client_ssl

echo "finished setting up kafka ssl"

kubectl create -f mirror-maker.yaml

echo "finished deploying mirror maker"