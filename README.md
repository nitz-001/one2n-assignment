### Directory Structure
An overview of the repo:- 
- cron 
    - metrics-cronjob.yaml :- YAML file for creating cronjob on k8s cluster.
    - metrics-pv.yaml :- YAML file for creating persistent volume on k8s cluster.
    - metrics-pvc.yaml :- YAML file for creating persistent volume claim on k8s cluster
- node-exporter
    - values-one2n.yaml :- values file for the node exporter.
    - also contains the rest of the files of helm chart. 
- script
    - Dockerfile :- dockerfile to containerize the script
    - script.sh :- bash script to scrape the metrics and store them in a file


### Steps to deploy :- 
1. Run a minikube cluster locally, create a namespace 'observability' and deploy node exporter by going inside node exporter directory and running the following command 
```console
kubectl create namespace observability
helm install node-exporter . -f values-one2n.yaml --namespace observability
```
2. Build a docker image for the script using the Dockerfile and push it to remote repository by using the following commands :- 
```console
docker build . -t metrics-collector
docker tag metrics-collector:latest <remote-repo>/metrics-collector:v1.0.0
docker push <remote-repo>/metrics-collector:v1.0.0
```
3. Now go to the cron directory. Here we have three files - metrics-cronjob.yaml, metrics-pv.yaml and metrics-pvc.yaml.
Delpoy these in the order given below :- 
```console
kubectl apply -f metrics-pv.yaml
kubectl apply -f metrics-pvc.yaml
kubectl apply -f metrics-cronjob.yaml
```

### TO check the output files
1. Go inside the minikube environment by running following command :- 
```console
minikube ssh
```
2. Go to the directory /one2n/metrics and you should see the output files there.