docker build -t jdraper29/multi-client:latest -t jdraper29/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jdraper29/multi-server:latest -t jdraper29/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jdraper29/multi-worker:latest -t jdraper29/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jdraper29/multi-client:latest
docker push jdraper29/multi-server:latest
docker push jdraper29/multi-worker:latest

docker push jdraper29/multi-client:latest:$SHA
docker push jdraper29/multi-server:latest:$SHA
docker push jdraper29/multi-worker:latest:$SHA

docker kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jdraper29/multi-server:$SHA
kubectl set image deployments/client-deployment client=jdraper29/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jdraper29/multi-worker:$SHA
