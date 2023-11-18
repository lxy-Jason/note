- 工作中一个有成就的点
- 问项目
- 参数透传($attrs和$listeners)
- ref指定组件后,怎么通过ref拿到组件的方法,vue3中怎么拿的(sonRef.value.methods())
- new做了哪些事?

```js
const obj =  {
  a:function(){
    console.log(this)
  },
  b:() => {
    console.log(this)
  }
}
obj.a() //值为什么
obj.b() //值为什么
```

纯小丑,说反了

- 事件循环
- 一个微任务中包含一个微任务,那这个微任务是在这一次宏任务重执行还是下一次宏任务中执行
- 使用定时器时,设置一秒执行一次,为什么实际上可能做不到一秒一执行,这个误差是怎么导致的
- 防抖和节流区别,使用场景
- 怎么实现节流,怎么先进行一次调用,再进行节流(节流立即执行版),注意第一次执行时不能开启定时器,导致默认的第二次执行
- 什么情况会导致跨域,设置cors为什么能解决跨域,options请求,什么时候会有options请求
- xmlHttpRequest和Fetch的实现
- axios中响应拦截器和请求拦截器是怎么实现的
- v-if和v-for的优先级
- created和mounted的区别,created中调用一个接口请求,然后接口函数的.then方法中可以拿到DOM元素吗?(可以拿到,因为请求本身是一个宏任务)
- nextTick为什么能拿到DOM