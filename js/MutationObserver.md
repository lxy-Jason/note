### 主要作用

MutationObserver可以观察整个文档,DOM树的一部分或者具体dom元素,

主要是观察元素的属性,子节点,文本的变化,并且可以在DOM被修改时异步执行回调(宏任务)

### 基本用法

通过MutationObserver构造函数传入一个回调函数来创建

回调函数接收两个参数

- mutationRecord -- 是一个数组存储的是 MutationRecord 的实例，数组的每一项包含发生了什么变化，以及 DOM 的哪一部分受到了影响。因为回调执行之前可能同时发生多个满足被观察 dom 修改的条件，所以当前回调就会被执行多次，每次执行回调都会传入一个包含按顺序入队的 MutationRecord 实例的数组；
- `mutationObserver` -- 是观察变化的 MutationObserver 实例，也就是外部实例化得到的 observer 对象；

[DOM 规范 —— MutationObserver 接口 - 掘金 (juejin.cn)](https://juejin.cn/post/7036733000565915655)