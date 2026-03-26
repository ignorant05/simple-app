# Simple-App

## Description 
A simple python fastApi app (serves as a placeholder for real app) used to demonstrate the CI/CD pipeline 

## Flow Overview 
```bash 
GitHub Push → GitHub Actions → Build & Test → Push to ECR → Deploy to EKS → Live App
```

## Stack Breakdown 
- python **v3.14.3**
- Docker **v29.3.0** (both client and server)
- Docker-compose **v5.1.0**
- Kubernetes (kubectl **v1.35.1**, Kustomize **v5.7.1**)
- AWS Services: VPC/ ECR/ EKS /EC2 /IAM 
- minikube **v1.38.1** (for local dev/test)

## Project Tree 
```bash.
simple-app
├── app
│   ├── main.py
│   └── requirements.txt
├── docker-compose.dev.yaml
├── docker-compose.yaml
├── Dockerfile
├── .gitignore
├── k8s
│   ├── deployment.yaml
│   ├── ingress.yaml
│   ├── resourceQuota.yaml
│   └── service.yaml
├── README.md
```

## Installation & Setup 
```bash 
# Clone and move into the simple-app dir
git clone https://github.com/ignorant05/simple-app 
cd simple-app

# setup minkube cluster with custom cpu/ram
minikube start --cpus 4 --memory 4096 
eval $(minikube docker-env)

# Note: if you encounter a docker issue, it's mostly because: 
    - docker.service isn't running, then just restart it
    - docker cannot authenticate you, then just use `docker logout`, `docker login` to reauthenticate

# building docker image 
# Note: if the image name is changed in the future in the deployment's template section, then you must change it too
#       if it is dynamic (with sed, which i plan to do) i'll make the necessary changes in this documentation
docker build -t simple-app:test . (for testing)

# loading image to minikube cluster
minikube image load simple-app:test 

# create a namespace 
kubectl create ns simple-app-ns

# apply changes to manifests with kubectl
kubectl apply -f k8s/

# Watch for errors via **describe/get/logs** subcommands

# if no errors found, then use your webclient or browser (because it's a fastApi app) to test it

# 1st method
# tunnel via minikube (straight forward)
minikube tunnel 

# get "ClusterIP" via svc resource
kubectl get svc -n simple-app-ns 

# use it to access the api, try the "/" and "/health" endpoints
# if you get messages in json format then you're good to go

# 2nd method
# port forwarding via kubectl
# i used port 8080 here but you can use any port that is not mapped to any external service on you local machine
kubectl port-forward -n simple-app-ns svc/simple-app-service 8080:80
```
