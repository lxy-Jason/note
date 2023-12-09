### 更新容器

```
 docker-compose up -d prod  mongodb mongo-express
```

### 设置容器中的实践

如果你已经创建了一个 Docker 容器并且想要更新容器的设置，你可以按照以下步骤进行操作：

1. 首先，使用 `docker ps` 命令查看正在运行的容器的列表，并找到你想要更新设置的容器的 ID 或者名称。

2. 使用 `docker exec` 命令进入正在运行的容器的命令行界面。例如，如果容器的 ID 是 `abcd1234`，则可以运行以下命令进入容器：

   ```
   docker exec -it abcd1234 /bin/bash
   ```

3. 进入容器后，你可以执行需要的命令来更新容器的设置。例如，如果你想要更新容器的时区设置，可以运行以下命令：

   ```
   ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
   echo 'Asia/Shanghai' > /etc/timezone
   ```

   这将会将容器的时区设置为上海。

4. 当你完成设置的更新后，可以使用 `exit` 命令退出容器的命令行界面。

请注意，这种方法只会在容器当前运行时生效。如果你停止并重新启动容器，你需要重新执行这些设置命令。如果你希望在创建容器时就设置好时区等设置，可以在 `Dockerfile` 中添加相应的命令来实现。

### 本地docker镜像怎么上传到仓库

```
docker iamges
```

查看当前本地镜像

```
REPOSITORY              TAG       IMAGE ID       CREATED       SIZE
server-prod             1.0.0     a3e300553bf5   6 days ago    1.23GB
mongo-express           latest    81bee2a0ce57   2 weeks ago   202MB
mongo                   5.0.0     2d38962b1e5e   2 years ago   671MB
```

这里注意三个东西,REPOSITORY,TAG和IMAGE ID

首先docker hub注册,自行解决

本地docker登录

```
docker login
```

推送到仓库

```
docker push xxx
```

常见错误

```
D:\front_end\lxy-blog-server> docker push lxyjason/lxy-blog-server:1.0  
The push refers to repository [docker.io/lxyjason/server-prod]
An image does not exist locally with the tag: lxyjason/server-prod
```

这里有个提交规范

```
docker push 用户名/仓库名:标签
```

这就是我前面为什么说要注意那三个东西

首先需要通过

```
docker tag xxx
```

让你本地仓库中希望上传的镜像设置成远端仓库中期望的镜像名

例如我这里本地是`server-prod`,但是我希望仓库中是`lxy-blog-server`

我就得

```
 docker tag a3e300553bf5 lxy-blog-server:1.0
```

`a3e300553bf5 lxy-blog-server:1.0`分别是镜像id,镜像名和标签

这个时候就可以推送了,这里有第二种错误

```
PS D:\front_end\lxy-blog-server> docker push lxy-blog-server:1.0         
The push refers to repository [docker.io/library/lxy-blog-server]
99234ae81add: Preparing                                                                                                                                                                                                                                                              15f0e9f7640e: Waiting                                                                                                                                                                                                               
denied: requested access to the resource is denied

```

就是因为我没在前面加上用户名

所以最终得

```
docker tag a3e300553bf5 lxyjason/lxy-blog-server:1.0
docker push lxyjason/lxy-blog-server:1.0   
```

### docker部署之后连不上数据库

我这边是因为数据库容器和后端容器用的同一个network

```
networks:
  server-network:
```

这里的解决办法是

```
docker run --net=host <images_id>
```

### next项目本地docker部署后无法访问

```
docker run -p 3000:3000 lxy-blog-web
```

终端中运行时指定端口,端口要和`Dockerfile`文件中,以及next start端口三组一致
