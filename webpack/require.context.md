一个webpack的api,通过执行require.context函数获取一个特定的上下文

主要用来实现自动化导入模块,可以不用import手动导入

### 三个参数

- 文件路径[string]
- 是否遍历文件的子目录[boolean]
- 匹配文件的正则表达式

语法: require.context(directory, useSubdirectories = false, regExp = /^.//);

例子: require.context('./test', false, /.test.js$/);

实践场景: require.context('../components/', true, /\w+\.(vue|js)$/)