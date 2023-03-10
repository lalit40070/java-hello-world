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
       
         /* stage('SonarQube analysis')  {
            steps {
                 withSonarQubeEnv('sonarqube-8.5.1') {
                   sh 'mvn -f my-app/pom.xml sonar:sonar'
                 }
           }
        } */
        
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
                  sh 'docker build -t lalitkr2506/my-app-main:${BUILD_NUMBER} .'
                }
            }
        }
  stage('Push Docker Image') {
            steps {
                script {
                 withCredentials([string(credentialsId: 'lalitkr2506', variable: 'dockerhubpwd')]) {
                    sh 'docker login -u lalitkr2506 -p ${dockerhubpwd}'
                 }  
                 sh 'docker push lalitkr2506/my-app-main:${BUILD_NUMBER}'
                sh 'docker rmi lalitkr2506/my-app-main:${BUILD_NUMBER}'
                }
            }
        }  
      stage('Deploying with kubernetes') {
            steps {
                script {
                 kubernetesDeploy configs: 'deployment.yml', kubeConfig: [path: ''], kubeconfigId: 'kubeconfig', secretName: '', ssh: [sshCredentialsId: '*', sshServer: ''], textCredentials: [certificateAuthorityData: '', clientCertificateData: '', clientKeyData: '', serverUrl: 'https://']                 }  
               }
            }
    }
}
