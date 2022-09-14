### 用途

官方说法:

`nextTick()` 可以在状态改变后立即使用，以等待 DOM 更新完成。你可以传递一个回调函数作为参数，或者 await 返回的 Promise。

简单的说:

可以获取到下一次页面更新之后的数据

### 用法

传递一个回调函数作为参数，或者 await 返回的 Promise

### 原理

vue中更改响应式数据,dom的更新并不是同步生效的,vue内部实现是使用一个队列进行缓存,等**同一事件循环**中的所有数据变化完成之后，再统一进行视图更新。

这样是为了节约性能,当组件发生多次状态改变时,仅执行一次更新

### 异步更新实现

通过**异步api**调用`flushCallbacks`函数

在此函数中可以依次执行之前队列中保存的回调函数,完成更新

### 异步api选择

`next-tick.js` 申明了 `microTimerFunc` 和 `macroTimerFunc` 2 个变量，它们分别对应的是 micro task 的函数和 macro task 的函数。对于 macro task 的实现，优先检测是否支持原生 `setImmediate`，这是一个高版本 IE 和 Edge 才支持的特性，不支持的话再去检测是否支持原生的 `MessageChannel`，如果也不支持的话就会降级为 `setTimeout 0`；而对于 micro task 的实现，则检测浏览器是否原生支持 Promise，不支持的话直接指向 macro task 的实现。

