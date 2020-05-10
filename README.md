# jenkins-k8s-minikube

## Getting started

Install helm v3
```shell script
$ brew install helm
```

Start minikube
```shell script
$ minikube --memory 4096 --cpus 2 start --vm-driver=virtualbox
```

Verify minikube is running
```shell script
$ minikube status
host: Running
kubelet: Running
apiserver: Running
kubeconfig: Configured
```

## Deploy Jenkins

Create namespace
```shell script
$ kubectl create -f minikube/jenkins-namespace.yaml
```

Create persistent volume (folder /data is persistent on minikube)
```shell script
$ kubectl create -f minikube/jenkins-volume.yaml
```

Execute helm
```shell script
$ helm install --name jenkins -f jenkins/jenkins-values.yaml stable/jenkins --namespace jenkins
```
