pipeline {
    agent any

    parameters {
        string(name: 'AWS_REGION', defaultValue: 'ap-south-1', description: 'AWS Region for deployment')
        string(name: 'EC2_INSTANCE_TYPE', defaultValue: 't2.micro', description: 'EC2 Instance Type')
    }

    environment {
        AWS_REGION = "${params.AWS_REGION}"
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')   // Fetch AWS credentials from Jenkins
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

    triggers {
        pollSCM('H/5 * * * *')   // Poll GitHub every 5 minutes for changes
    }

    stages {
        stage('Checkout Code') {
            steps {
                script {
                    echo 'Checking out source code...'
                    checkout([$class: 'GitSCM', branches: [[name: '*/main']],
                        userRemoteConfigs: [[url: 'https://github.com/tharundevops4/terraformtest.git']]
                    ])
                }
            }
        }

        stage('Initialize Terraform') {
            steps {
                script {
                    echo 'Initializing Terraform...'
                    sh 'terraform init'
                }
            }
        }

        stage('Validate Terraform') {
            steps {
                script {
                    echo 'Validating Terraform configuration...'
                    sh 'terraform validate'
                }
            }
        }

        stage('Plan Infrastructure Changes') {
            steps {
                script {
                    echo 'Generating Terraform execution plan...'
                    sh 'terraform plan -var="aws_region=${AWS_REGION}" -var="instance_type=${params.EC2_INSTANCE_TYPE}"'
                }
            }
        }

        stage('Apply Infrastructure Changes') {
            steps {
                script {
                    echo 'Applying Terraform changes...'
                    sh 'terraform apply -auto-approve -var="aws_region=${AWS_REGION}" -var="instance_type=${params.EC2_INSTANCE_TYPE}"'
                }
            }
        }

        stage('Retrieve Terraform Outputs') {
            steps {
                script {
                    echo 'Fetching Terraform outputs...'
                    sh 'terraform output'
                }
            }
        }
    }

    post {
        success {
            echo 'Terraform applied successfully. EC2 and EBS are created!'
        }
        failure {
            echo 'Terraform deployment failed!'
        }
    }
}
