```
npm init -y
```

可选参数-y，其含义是在项目初始化时，采用系统默认的基本配置信息。如果没有此参数，在npm init命令执行过程中，会有一系列参数让用户即时输入。

```
#! /usr/bin/env node
```

增加这一行是为了指定用node执行脚本文件。

### npm install <package>

- `dependencies`：它包含的依赖包是需要发布到生产环境中的，是项目正常运行必须依赖的包。
- `devDependencies`：它包含的依赖包只在开发时使用，不用于生产环境，如果只需要项目正常运行，则不必安装这里面的包。

> 安装某个包时，这个包中package.json的dependencies字段中的依赖会被自动安装，而devDependencies字段中的依赖不会被安装。

无参数(默认情况)会将包安装到dependencies中

--save 和默认效果一样,添加到dependencies中

--save-dev 将包安装到devDependencies中

