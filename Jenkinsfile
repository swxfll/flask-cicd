pipeline {
    agent any

    parameters {
        string(name: 'IMAGE_TAG', defaultValue: 'latest', description: 'Docker image tag')
    }

    environment {
        // 从 Docker 仓库中下载已构建的镜像，并将其部署到目标节点
        NODE_IP = "192.168.111.161"

        // 目标节点的用户名和密码, 需要具有ssh远程登录权限和docker操作权限
        NODE_USER = "root"
        NODE_PASSWORD = "root"

        // 项目代码地址
        GIT_URL = "https://github.com/swxfll/flask-cicd.git"
        //GIT_URL = "https://gitee.com/yun_guo/flask-cicd.git"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: "${env.GIT_URL}"
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t flask-cicd:${params.IMAGE_TAG} ."
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: '71a4e097-af09-4b34-a1e0-57209d0242da', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh "docker login -u $USERNAME -p $PASSWORD"
                }
                sh "docker tag flask-cicd:${params.IMAGE_TAG} ksand/flask-cicd:${params.IMAGE_TAG}"
                sh "docker push ksand/flask-cicd:${params.IMAGE_TAG}"
            }
        }

        stage('Send Hello to Remote Host') {
            steps {
                script {
                    def remote = [:]
                    remote.name = "${env.NODE_IP}"
                    remote.host = "${env.NODE_IP}"
                    remote.user = "${env.NODE_USER}"
                    remote.password = "${env.NODE_USER}"
                    remote.allowAnyHosts = true
                    sshCommand remote: remote, command: "docker pull ksand/flask-cicd:${params.IMAGE_TAG} && docker run -id -p 5000:5000 ksand/flask-cicd:${params.IMAGE_TAG}"
                }
            }
        }

        stage('Send Notification to Feishu') {
            steps {
                script {
                    def url = 'https://open.feishu.cn/open-apis/bot/v2/hook/f4f74fed-12cd-4d44-9775-5244d013e10d'
                    def message = """
                        {
                            "msg_type": "text",
                            "content": {
                                "text": " Flask application built successfully! Version is: ksand/flask-cicd:${params.IMAGE_TAG}"
                            }
                        }
                    """
                    def response = httpRequest httpMode: 'POST', url: url, requestBody: message
                    echo "HTTP status code: ${response.status}"
                    echo "Response body: ${response.content}"
                }
            }
        }
    }
}
