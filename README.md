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

Prepare the deployment
```shell script
$ kubectl create -f minikube/jenkins-namespace.yaml
$ kubectl create -f minikube/jenkins-volume.yaml
```

> Yes, you can `$ kubectl create -f minikube/` that if you want to live on the edge 🔥

Execute helm
```shell script
$ helm install --name jenkins -f jenkins/jenkins-values.yaml stable/jenkins --namespace jenkins
```

> You may need to `$ helm repo add stable https://kubernetes-charts.storage.googleapis.com`

Login
`admin/admin` 🚨
