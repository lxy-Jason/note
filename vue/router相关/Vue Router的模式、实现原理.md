### 两种模式

#### Hash模式

`#`以及它后面的字符称为hash

可以通过window.location.hash读取

hash出现在URL中但是不会被包括在HTTP请求中,改变hash不会重新加载页面

可以为hash的改变添加监听事件

```js
window.addEventListener("hashchange",funcRef,false)
```

 每次改变hash,都会在浏览器的访问记录中增加一个记录

hash模式就是基于这个原理,实现更新视图但是不重新请求页面

### History模式

浏览器提供了History API,有back().forwrad(),go()等方法

在HTML5的时候提供了两个新的方法:pushState(),replaceState()

这两个方法可以对浏览器历史记录进行修改

```js
window.history.pushState(stateObject, title, URL)
window.history.replaceState(stateObject, title, URL)
```

stateObject:当浏览器跳转到新的状态时,将触发popState事件,该事件将携带这个stateObject参数的副本

title:所添加记录的标题

URL:所添加记录的URL

**这两个方法有个共同的特点: 当调用他们修改浏览器历史记录栈后,URL会改变,但是浏览器不会刷新**

这就是history模式的原理