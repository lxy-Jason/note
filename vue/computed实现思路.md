- 给computed属性创建Watcher(computed-watcher)
- 将这个Watcher添加到computed属性使用了的响应式数据的Dep中
- computed属性值的变化来自data中属性的变化,要想使用了computed属性的模板跟着变化,就得把对应的render-watcher添加到与computed属性相关的data属性的Dep中



### 具体流程

render函数执行时,触发了computed属性的get

在get中依次做了几件事:

- 执行computed属性函数,将函数返回值保存起来

​	注意,执行computed函数的过程中,data属性值被get了.

- data属性值把当前的computed属性的watcher添加到订阅队列中
- data属性值把render-watcher添加到订阅队列中
- 返回保存起来的computed函数执行结果

https://juejin.cn/post/6844904128435453966

参考文章