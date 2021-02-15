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
                  
                    docker.withRegistry("https://myacrtemp.azurecr.io", 'acr_id') {
                        def testImage = docker.build("javaimagewithoutwebsphere:${env.BUILD_ID}", './')
                        testImage.push()
              }
              }
              
            }
         }
          stage('Deploy- using Helm') {
                
            steps{         
            powershell('helm package ./nodejs')
             powershell('helm upgrade new nodejs-0.1.0.tgz')    
            
             powershell("docker run -dp 5000:5000 --restart=always --name registry registry")             
             powershell("helm registry login -u jai localhost:5000 --password-stdin -unsecure")
            powershell("helm chart save ./nodejs/ localhost:5000/nodejs/nodejs:1.0.0")
            powershell("helm chart list")
            powershell("helm chart export localhost:5000/nodejs/nodejs:1.0.0")
            powershell("helm chart push localhost:5000/nodejs/nodejs:1.0.0")
            powershell("helm chart remove localhost:5000/nodejs/nodejs:1.0.0")
            powershell("helm chart pull localhost:5000/nodejs/nodejs:1.0.0")
            powershell("helm chart export localhost:5000/nodejs/nodejs:1.0.0")
            powershell("helm chart list")
           
            powershell("helm install newrelease nodejs/")
             powershell("helm registry logout localhost:5000")
             powershell("docker rm -f registry")
             
             
            }
         }
    }
  
}