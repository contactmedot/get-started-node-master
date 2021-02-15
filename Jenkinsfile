pipeline {
    agent any
    environment {
                    HELM_EXPERIMENTAL_OCI=1
                    KUBECONFIG = 'C:/Users/shivam/.kube/config'
                }
    stages {
        stage('Build') {           
            steps {      
                echo '************************************************************************'        
                echo '************************************************************************'        
               
                echo "Running ${env.BUILD_ID} on ${env.JENKINS_URL}"
                echo "${env.JENKINS_HOME}"
                echo "${env.WORKSPACE}"
               
                               
                echo '************************************************************************'        
                echo '************************************************************************'     
                echo 'Building..'
            }
        }
         stage('Create Docker Image Registry') {
            steps{
             
              script {
                  
                    // docker.withRegistry("https://myacrtemp.azurecr.io", 'acr_id') {
                    //     def testImage = docker.build("javaimagewithoutwebsphere:${env.BUILD_ID}", './')
                    //     testImage.push()
                        docker.withRegistry("https://registry.hub.docker.com",'docker_id') {
                        def testImage = docker.build("dockershivam2020/nodejsimage:${env.BUILD_ID}", './')
                        testImage.push()
              }
              }
              
            }
         }
          stage('Deploy- using Helm') {
                
            steps{         
            powershell('helm package ./nodejs')
             powershell('helm install newupdate nodejs-0.1.0.tgz')    
            
            
             
             
            }
         }
    }
  
}