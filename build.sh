#!/usr/bin/env bash

echo 'Start minikube'
minikube --memory 4096 --cpus 2 start --vm-driver=virtualbox

echo 'Create jenkins namespace'
kubectl create -f jenkins/jenkins-namespace.yaml

echo 'Create jenkins volume'
kubectl create -f jenkins/jenkins-volume.yaml

echo 'Create jenkins role bind access controller'
kubectl create -f jenkins/jenkins-rbac.yaml

echo 'Create jenkins volume and edit permissions'
ssh -t -i $(minikube ssh-key) docker@$(minikube ip) "sudo mkdir /mnt/data/"
ssh -t -i $(minikube ssh-key) docker@$(minikube ip) "sudo chown -R 1000 /mnt/data/"

echo 'Install jenkins chart'
helm upgrade --install jenkins -f jenkins/jenkins-values.yaml stable/jenkins --namespace jenkins

echo 'Wait until pod is running (this may take a while)'
while \
[[ $(kubectl -n jenkins get pods -l app.kubernetes.io/component=jenkins-master -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]];\
do echo "Waiting for jenkins to be running..." && sleep 20; done

echo 'Opening jenkins on browser'
minikube service jenkins -n jenkins
