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
   
        
        stage('SonarQube analysis')  {
            steps {
                 withSonarQubeEnv('sonarqube-8.5.1') {
                   sh 'mvn -f my-app/pom.xml sonar:sonar'
                 }
           }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                  sh 'docker build -t dockerrepo:${BUILD_NUMBER} .'
                }
            }
        }
  stage('Docker Tag Image') {
            steps {
                script {
                   sh 'aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 226100319488.dkr.ecr.ap-south-1.amazonaws.com'
                }
            }
        }  
        stage('Docker Tag Image') {
            steps {
                script {
                 sh 'docker push dockerrepo:${BUILD_NUMBER} 226100319488.dkr.ecr.ap-south-1.amazonaws.com/dockerrepo:${BUILD_NUMBER}'
                }
            }
        }  
   stage('Docker Push Image') {
            steps {
                script {
                 sh 'docker push 226100319488.dkr.ecr.ap-south-1.amazonaws.com/dockerrepo:${BUILD_NUMBER}'
                }
            }
        }  
    
    }
}
