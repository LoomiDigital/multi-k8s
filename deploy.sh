docker build -t barabis/multi-client:latest -t barabis/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t barabis/multi-server:latest -t barabis/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t barabis/multi-worker:latest -t barabis/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push barabis/multi-client:latest
docker push barabis/multi-server:latest
docker push barabis/multi-worker:latest

docker push barabis/multi-client:$SHA
docker push barabis/multi-server:$SHA
docker push barabis/multi-worker:$SHA

kubectl apply -f ./k8s

kubectl set image deployments/client-deployment client=barabis/multi-client:$SHA 
kubectl set image deployments/server-deployment server=barabis/multi-server:$SHA 
kubectl set image deployments/worker-deployment worker=barabis/multi-worker:$SHA 