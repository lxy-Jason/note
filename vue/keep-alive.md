设置keep-alive缓存的组件会多出两个生命周期钩子(`activated`和`deactivated`):

- 首次进入组件时:`beforeRouteEnter`>`beforeCreate`>`created`>`mounted`>`activated`>....>`beforeRouteLeave`>`deactivated`
- 再次进入组件时:`beforeRouteEnter`>`activated`>....>`beforeRouteLeave`>`deactivated`

所以使用keep-alive可以避免组件销毁,`activated`钩子触发在mounted之后,也就是dom渲染之后

### 使用场景

需要保存路由跳转之前页面状态的场景

比如我们做一个筛选功能得到想要的数据之后,点击数据去看具体详情

那么这里就需要保留筛选之后的状态,这样我们返回之后可以继续选择其他数据查看

### 缓存后如何获取数据

- beforeRouteEnter
- activated

这两个在有keep-alive的组件中每次进入时都会触发,可以通过这两个钩子去获取数据

**注意:服务端渲染期间`activate`不被调用**