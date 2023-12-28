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
    
        stage('testing') {
            steps {
                sh '''  
                   mkdir test
                    echo 'hello world'
                    '''
            }
        }
    }
}
