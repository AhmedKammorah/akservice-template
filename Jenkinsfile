pipeline{
    environment {
        
        // Start Changable Area 
        bitbucket_branch = 'master'
        git_repo = ''
        // <docker image name>
        registry_image_name = ""
        build_version = "1."
        AK_SERVICE_NAME=''
        // End Changable Area        
        
        // Configered on Slack
        BitbucketCredential=""
        AWSCredintial = ''
        KubernetesCredintial = ''
        PriRegistryCredential = ''
        SlackCredintial      = ''
        
   
        aws_registry = ''
        registry_image = "$registry_image_name:"
        build_no = "$BUILD_NUMBER"
        
        image_base = "${aws_registry}${registry_image}" 
        image = "${image_base}${build_version}${build_no}"
        
        base_aws_registry = ''

        AK_IMAGE_NAME = "${base_aws_registry}${registry_image}${build_version}${build_no}"
        
        slack_channel =  'jenkins_notifications'
        slack_username = 'jenkins'
        slack_hookUrl  = ''
        slack_workSpace= ''

        deployment_file = 'deploy.sh'
        kube_server_url = 'https://kubernetes.default'

    }
    
    agent any
    stages{
        // Slack start
        stage('Notification operation Start'){
            steps{
                slackSend (channel: slack_channel, color: '#FFFF00', message: "STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})",username:slack_username, teamDomain: slack_workSpace, baseUrl: slack_hookUrl, tokenCredentialId: SlackCredintial)
            }
        }

        stage('backend operation'){
            steps{
                git url: git_repo,
                    credentialsId: BitbucketCredential,
                    branch: bitbucket_branch
            }
        }

        stage('Build image and push') {
            steps{
              script {
                    // Build Docker image 
                   
              }

              script {
                    // push docker iamge to private regestery
                    
                }
            }
        }
        
       stage('Apply Tenants files') {
                  steps{
                      withKubeConfig([credentialsId: KubernetesCredintial, serverUrl: kube_server_url]) {
                      sh 'chmod +x $deployment_file'
                      sh "sh $deployment_file tenants ${AK_IMAGE_NAME}"
                      }
                  }
              }

        stage('Notification operation End') {
            steps{
                slackSend (channel: slack_channel, color: '#FFFF00', message: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})",username:slack_username, teamDomain: slack_workSpace, baseUrl: slack_hookUrl, tokenCredentialId: SlackCredintial)

            }    
        }


    }

}
