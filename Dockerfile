# 使用 Python 官方提供的 Python 运行时作为基础镜像
FROM python:3.8-slim-buster

# 设置工作目录
WORKDIR /app

# 复制应用程序代码到工作目录
COPY . /app

# 安装应用程序依赖项
RUN pip install --no-cache-dir -r requirements.txt

# 暴露应用程序使用的端口
EXPOSE 5000

# 设置环境变量
ENV FLASK_APP app.py

# 启动应用程序
#CMD ["flask", "run", "--host", "0.0.0.0:5000"]
CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0", "--port=5000"]