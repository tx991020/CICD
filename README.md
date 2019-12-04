#基础镜像列表
1 go打包镜像
registry.cn-hangzhou.aliyuncs.com/guanghe/golang:latest

2 测试镜像
registry.cn-hangzhou.aliyuncs.com/guanghe/go-hello:latest

# CentOS GitLab-Runner 安装指南
先安装docker
```$xslt
sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2
```
```$xslt
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
```

```$xslt
sudo yum install docker-ce
```

```$xslt
sudo systemctl start docker
```


```$xslt
sudo wget -O /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/ \
gitlab-runner-linux-amd64
```

```$xslt
chmod +x /usr/bin/gitlab-runner
```

```$xslt
gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner
```

gitlab-runner start

查看已经的runner 
gitlab-runner  list 

注册runner示例
```$xslt
gitlab-runner register -n --url  https://gitlab.yc345.tv/ --registration-token -XXX  --executor docker --description \
 "yourname" --docker-image "library/docker:17.12.1-ce" --docker-volumes /var/run/docker.sock:/var/run/docker.sock
```