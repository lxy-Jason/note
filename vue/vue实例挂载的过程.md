vue实例挂载的过程就是new Vue的过程

### 调用`_init`方法

定义`$set`,`$get`,`$delete`,`$watch`等方法

定义`$on`,`$off`,`$emit`等事件

定义 `_update`、`$forceUpdate`、`$destroy`生命周期

```js
initMixin(Vue);     // 定义 _init
stateMixin(Vue);    // 定义 $set $get $delete $watch 等
eventsMixin(Vue);   // 定义事件  $on  $once $off $emit
lifecycleMixin(Vue);// 定义 _update  $forceUpdate  $destroy
renderMixin(Vue);   // 定义 _render 返回虚拟dom
```



### 调用`$mount`进行页面挂载

### 定义updateComponent更新函数

### 执行render生成虚拟dom

### `_update`将虚拟dom生成真实dom,并渲染到页面中

