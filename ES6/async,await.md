async和await关键字让我们可以用一种更简洁的方式写出基于`promise`的异步行为,而无需刻意地链式调用`promise`

感觉就是用同步的写法执行异步操作

async返回值是一个状态为fulfilled的promise对象,值为函数的return值

### 描述

async函数可能包含0个或者多个`await`表达式

await表达式会暂停整个async函数的执行进程并让出其控制权

只有当其等待的基于promise的异步操作被兑现或者拒绝之后才会恢复进程

promise的解决值会被当做该await表达式的返回值

async和await的目的是为了简化使用基于promise的API时所需语法

async函数一定会返回一个promise,如果看起来不像,也是被隐式的包装在一个promise中

```js
async function foo() {
  return 1;
}
//等价于
function foo() {
  return Promise.resolve(1);
}
```

在async函数中从第一行代码直到(并包括)第一个await表达式的执行都是同步的

表达式指的是await关键字后面的内容

async函数的返回值隐式传递给Promise.resolve

await后面是可以接普通函数的和字面量的,不一定要异步函数













