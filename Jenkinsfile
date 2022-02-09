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
                  sh 'docker build -t lalitkr2506/my-app-1.2 .'
                }
            }
        }
  stage('Push Docker Image') {
            steps {
                script {
                 withCredentials([string(credentialsId: 'lalitkr2506', variable: 'dockerhubpwd')]) {
                    sh 'docker login -u lalitkr2506 -p ${dockerhubpwd}'
                 }  
                 sh 'docker push lalitkr2506/my-app-1.2'
                }
            }
        }  
    }
}
