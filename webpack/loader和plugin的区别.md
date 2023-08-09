Loader：用于对模块源码的转换，loader描述了webpack如何处理非javascript模块，并且在build中引入这些依赖。loader可以将文件从不同的语言（如TypeScript）转换为JavaScript。

Plugin：目的在于解决loader无法实现的其他事，从打包优化和压缩，到重新定义环境变量，功能强大到可以用来处理各种各样的任务。

### 区别

简单的说loader是将浏览器不能识别的代码转化成可以识别的代码,例如浏览器不认识ts,less,通过webpack转换成js,css

plugin是用于扩展webpack的能力,在`Webpack` 运行的生命周期中会广播出许多事件，`Plugin` 可以监听这些事件，在合适的时机通过`Webpack`提供的 `API`改变输出结果

#### 在运行时机上的区别

loader运行在打包文件之前

plugins在整个编译周期都起作用

<img src="image/9a04ec40-a7c2-11eb-ab90-d9ae814b240d.png" alt="img" style="zoom:50%;" />