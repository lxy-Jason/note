### 用处

用于表示一个异步操作的最终完成(或失败)及其它的结果值

### 三种状态

- 待定 pending : 初始状态,既没有被兑现,也没有被拒绝
- 已兑现 fulfilled : 意味着操作成功
- 已拒绝 rejected : 意味着操作失败

### 链式调用(实例方法)

当第二个操作需要第一个操作完成之后再执行,就非常适合用链式调用

promise链式调用一般用于等待异步任务完成之后执行下一步操作

- `.then()`方法需要两个参数,第一个参数作为已兑现(fulfilled)状态时执行的回调函数,第二个参数作为已拒绝(rejected)状态时的回调函数
- `.catch()` 其实只是**没有给处理已兑现状态的回调函数预留参数位置**的 `.then()` 而已,相当于一个简便写法
- `.finally()` 当promise状态确定,不论是fulfilled还是rejected都会被调用

**注意点:**

- 这三个方法都返回一个promise对象,以便继续链式调用

### 静态方法

- Promise.all(iterable),返回一个promise

  当所有promise都成功时将一个包含所有promise返回值的数组作为成功回调的返回值

​	   当其中一个promise失败,就立即以这个promise失败的理由reject返回的promise

- Promise.allSettled(iterable),返回一个promise

  当所有promise都敲定(每个promise都已兑现或者已拒绝)

  resolve一个包含所有promise返回值的数组

- Promise.any(iterable)

  接收一个promise对象的集合,当其中一个promise成功,就返回那个成功的promise的值

- Promise.race(iterable)

  等到任一promise的状态敲定

- Promise.resolve(value) 返回一个状态由给定的value决定的Promise对象

  如果是带有`then`方法的对象,返回的promise的最终状态由`then`方法执行结果决定

  如果不是,返回的promise对象状态为fulfilled,并将该value传递给对应的then方法

- Promise.reject() 返回一个状态为已拒绝的Promise对象,并将给定的失败信息传递给对应的处理函数

### promise解决了什么问题

解决了回调地狱的问题

回调地狱带来的问题

- 可读性问题
- 信任问题

#### 可读性问题

回调地狱表现为多层异步函数嵌套调用

这种写法在阅读上和维护上很困难

通过promise的链式调用可以解决这个问题

#### 信任问题

回调函数什么时候执行会受到其他方面因素的影响,比如网络

这就可能出现回调过早执行,不执行,多次执行的问题

**对于过早执行**

由于Promise是只能是异步的,所以不会出现异步的同步回调,

即使是在决议之前的错误也是异步的,不会产生同步(调用过早)问题

**对于调用过晚或者没有调用的问题**

Promise本身不会回调过晚,只要决议了,它就会按照规定运行

**对于回调次数太少或者太多的问题**

Promise只能被决议一次,且决议之后无法改变

所以多次回调也不会影响结果,决议之后的回调会被忽略

