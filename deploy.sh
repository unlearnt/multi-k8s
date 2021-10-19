docker build -t unlearnt/multi-client:latest -t unlearnt/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t unlearnt/multi-server:latest -t unlearnt/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t unlearnt/multi-worker:latest -t unlearnt/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push unlearnt/multi-client:latest
docker push unlearnt/multi-server:latest
docker push unlearnt/multi-worker:latest

docker push unlearnt/multi-client:$SHA
docker push unlearnt/multi-server:$SHA
docker push unlearnt/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=unlearnt/multi-server:$SHA
kubectl set image deployments/client-deployment client=unlearnt/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=unlearnt/multi-worker:$SHA