pipeline {
    agent any
    options {
        buildDiscarder logRotator(daysToKeepStr: '5', numToKeepStr: '10')
    }
    stages {
        stage('Compile and Clean') { 
            steps {

                sh "mvn -f my-app/pom.xml clean compile"
            }
        }
               
        stage('test') { 
            steps {

                sh "mvn -f my-app/pom.xml test"
            }
        }
     
        stage('package') { 
            steps {
                sh "mvn -f my-app/pom.xml package"
            }
        }
         stage('Archving') { 
            steps {
                 archiveArtifacts '**/target/*.jar'
            }
        }
  
        stage('Build Docker Image') {
            steps {
                script {
                  sh 'docker build -t lalitkr2506/my-app-developer:${BUILD_NUMBER} .'
                }
            }
        }
  stage('Push Docker Image') {
            steps {
                script {
                 withCredentials([string(credentialsId: 'lalitkr2506', variable: 'dockerhubpwd')]) {
                    sh 'docker login -u lalitkr2506 -p ${dockerhubpwd}'
                 }  
                 sh 'docker push lalitkr2506/my-app-developer:${BUILD_NUMBER}'
                 sh 'docker rmi lalitkr2506/my-app-developer:${BUILD_NUMBER}'
                 sh 'ssh root@3.6.92.56 docker run -d --name lalit-developer-${BUILD_NUMBER} lalitkr2506/my-app-developer:${BUILD_NUMBER}'
                }
            }
        }  
    }
}
