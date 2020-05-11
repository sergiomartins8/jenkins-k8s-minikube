# jenkins-k8s-minikube

## Getting started

#### Install helm
```shell script
$ brew install helm
```
> [Helm v3](https://helm.sh/docs/intro/install/) is strongly recommended ⚠️

#### Start minikube
```shell script
$ minikube --memory 4096 --cpus 2 start --vm-driver=virtualbox
```

#### Verify minikube is running
```shell script
$ minikube status
host: Running
kubelet: Running
apiserver: Running
kubeconfig: Configured
```

## Deploy Jenkins

#### Prepare the deployment
```shell script
$ kubectl create -f minikube/jenkins-namespace.yaml
$ kubectl create -f minikube/jenkins-volume.yaml
```
> Yes, you can `$ kubectl create -f minikube/` that if you want to live on the edge 🔥

#### Execute helm
```shell script
$ helm install --name jenkins -f jenkins/jenkins-values.yaml stable/jenkins --namespace jenkins
```
> You might need to `$ helm repo add stable https://kubernetes-charts.storage.googleapis.com`

#### Persistent volume permissions
```shell script
$ minikube ssh
$ sudo chown -R 1000 /mnt/data/
$ exit
```

#### Login
```shell script
$ minikube service jenkins -n jenkins
``` 
> admin/admin 🚨
