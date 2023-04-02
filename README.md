## 主题

**基于 Jenkins 和 Docker 的全自动化 Flask 应用 CI/CD 部署流程实践**

## 此项目的 Flask 实现了哪些功能

直接访问 `127.0.0.1:5000` 会返回当前时间，用于测试 CD/CD

## pipeline 在哪里

`pipeline`内容请参考`Jenkinsfile`文件

## 流程图
![img.png](img.png)

## 如何部署

请修改 `pipeline` 脚本中的 `environment` 部分, 以及使用有效的 `凭据ID` 替换 `credentialsId`

>[详细教程(待完成)](https://note.youdao.com/s/PKwOejiT)