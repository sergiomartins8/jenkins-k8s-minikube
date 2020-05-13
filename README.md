# jenkins-k8s-minikube

### Prerequisites

##### Install helm
```shell script
$ brew install helm
```
> [Helm v3](https://helm.sh/docs/intro/install/) is strongly recommended ⚠️

##### Helm repo update
````shell script
$ helm repo add stable https://kubernetes-charts.storage.googleapis.com
````

### Getting started

##### Execute the following script
````shell script
$ ./build.sh
````
> Jenkins credentials: admin/admin 🚨

##### Jenkinsfile example
````groovy
podTemplate(label: 'mypod', containers: [
    containerTemplate(name: 'base', image: 'sergiomartins8/jenkins-slave-base:1.0', ttyEnabled: true, command: 'cat')
  ],
  volumes: [
    hostPathVolume(mountPath: '/var/run/docker.sock', hostPath: '/var/run/docker.sock'),
  ]
  ) {
    node('mypod') {
        stage('Check running containers') {
            container('base') {
                sh """set -e; mvn -B archetype:generate -DarchetypeGroupId=com.github.sergiomartins8 \
                         -DarchetypeArtifactId=ui-automation-bootstrap \
                         -DarchetypeVersion=1.2.0 \
                         -DgroupId=awesome.group.id \
                         -DartifactId=awesome-template \
                         -Dcheckstyle=true \
                         -Dreports=true"""

                dir('awesome-template') {
                    sh 'mvn -B clean validate'
                }    
            }
        }
    }
}
````
