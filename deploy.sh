docker build -t kuppusv/multi-client:latest -t kuppusv/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kuppusv/multi-server:latest -t kuppusv/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kuppusv/multi-worker:latest -t kuppusv/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push kuppusv/multi-client:latest
docker push kuppusv/multi-server:latest
docker push kuppusv/multi-worker:latest
docker push kuppusv/multi-client:$SHA
docker push kuppusv/multi-server:$SHA
docker push kuppusv/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kuppusv/multi-server:$SHA
kubectl set image deployments/client-deployment client=kuppusv/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kuppusv/multi-worker:$SHA
