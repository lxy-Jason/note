可以使用`setTimeout`函数来模拟实现`setInterval`的效果。下面是一个示例代码：

```javascript
function mySetInterval(callback, delay) {
  function interval() {
    callback();
    setTimeout(interval, delay);
  }
  setTimeout(interval, delay);
}

// 使用示例
function myCallback() {
  console.log('Hello, world!');
}

mySetInterval(myCallback, 1000);
```

在上面的代码中，`mySetInterval`函数接受两个参数：`callback`是要执行的回调函数，`delay`是时间间隔（以毫秒为单位）。

在`interval`函数内部，首先执行回调函数`callback`，然后再通过`setTimeout`函数设置下一次执行`interval`函数的延迟时间为`delay`。

最后，在`mySetInterval`函数中，通过调用`setTimeout`函数来启动第一次执行`interval`函数的延迟时间为`delay`。

这样，每次`interval`函数执行完毕后，会再次通过`setTimeout`函数设置下一次执行的延迟时间，从而模拟了`setInterval`的效果。