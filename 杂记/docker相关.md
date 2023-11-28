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
