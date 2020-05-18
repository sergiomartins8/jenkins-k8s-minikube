# jenkins-k8s-minikube

### Prerequisites

#### Install kubectl
```shell script
$ brew install kubectl
```

#### Install virtualbox
```shell script
$ brew cask install virtualbox
```

##### Install helm
```shell script
$ brew install helm
```
> [Helm v3](https://helm.sh/docs/intro/install/) is strongly recommended ⚠️

##### Helm repo update
```shell script
$ helm repo add stable https://kubernetes-charts.storage.googleapis.com
```

### Getting started

##### Execute the following script
```shell script
$ ./build.sh
```
> Jenkins credentials: admin/admin 🚨

##### Jenkinsfile example
```groovy
podTemplate(label: 'jenkins-slave-base-pod', serviceAccount: 'jenkins', containers: [
    containerTemplate(
        name: 'base', 
        image: 'sergiomartins8/jenkins-slave-base:1.0', 
        ttyEnabled: true, 
        command: 'cat'
    )
  ],
  volumes: [
    hostPathVolume(mountPath: '/var/run/docker.sock', hostPath: '/var/run/docker.sock')
  ]
  ) {
    node('jenkins-slave-base-pod') {
        stage('Awesome stage') {
            container('base') {
                sh 'kubectl get po'
                sh 'helm env'
            }
        }
    }
}
```

Checkout the complete article [here](https://medium.com/@sergiomartins8/highly-scalable-jenkins-on-minikube-8cc289a31850).
