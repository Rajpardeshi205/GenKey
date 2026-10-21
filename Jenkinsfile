pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'us-east-1'
        AWS_CREDS          = credentials('aws-credentials')
        AWS_ACCESS_KEY_ID     = "${AWS_CREDS_USR}"
        AWS_SECRET_ACCESS_KEY = "${AWS_CREDS_PSW}"
    }

    stages {
        stage('Terraform') {
            steps {
                sh '''
                    terraform init
                    terraform validate
                    terraform apply -auto-approve
                '''
                script {
                    env.EC2_IP = sh(script: 'terraform output -raw public_ip', returnStdout: true).trim()
                }
                echo "Server IP: ${env.EC2_IP}"
            }
        }

        stage('Generate SSH Key') {
            steps {
                sshagent(['id_rsa']) {
                    sh '''
                        ssh -o StrictHostKeyChecking=accept-new ec2-user@$EC2_IP '
                            [ -f ~/.ssh/id_ed25519 ] || ssh-keygen -t ed25519 -N "" -f ~/.ssh/id_ed25519
                            cat ~/.ssh/id_ed25519.pub
                        '
                    '''
                }
            }
        }
    }
}
