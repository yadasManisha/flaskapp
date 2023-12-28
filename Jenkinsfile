pipeline {
    agent {
        label any
    }

    environment {
        ssh_key_prod = credentials('ssh_key')
        prod_server_ip = 'ec2-13-126-204-124.ap-south-1.compute.amazonaws.com'
        staging_server_ip = 'ec2-13-235-94-77.ap-south-1.compute.amazonaws.com'
        uat_server_ip = 'ec2-13-233-54-99.ap-south-1.compute.amazonaws.com'

    }

    stages {
        stage('ssh connection') {
            steps {
                script {
                    def sshCommand = ''
                    // Determine the environment and set the SSH key accordingly
                    if (BRANCH_NAME == 'prod') {
                        sshCommand = """ssh -i ${ssh_key_prod} ${prod_server_ip}"""
                    } else if (BRANCH_NAME == 'stage') {
                        sshCommand = """ssh -i ${ssh_key_stage} ${staging_server_ip}"""
                    } else if (BRANCH_NAME == 'uat') {
                        sshCommand = """ssh -i ${ssh_key_uat} ${uat_server_ip}"""
                    } else {
                        error "Unsupported environment"
                    }

                    sh '$sshCommand'
                }
            }
        }

        stage('checkout') {
            steps {
                git branch: "${BRANCH_NAME}", credentialsId: 'your-git-credentials-id', url: 'https://github.com/your/repo.git'
            }
        }

        stage('deploy') {
            steps {
                sh '''                    
                    sudo apt update -y
                    sudo apt-get install python3 -y
                    cd /home/jenkins/workspace/flaskapp
                    pip3 install flask
                    nohup python3 app.py
                    '''
            }
        }
    }
}
