### 基础版(只能进行同步任务)

```js
//三个状态
const PENDING = "PENDING";
const FULFILLED = "FULFILLED";
const REJECTED = "REJECTED";

class Promise {
  constructor(executor) {
    //默认状态为PENDING
    this.status = PENDING;
    //存放成功状态的值,默认为undefined
    this.value = undefined;
    //存放失败状态的值,默认为undefined
    this.reason = undefined;

    //成功方法
    let resolve = (value) => {
      //状态为PENDING时才可以更新状态,防止executor中调用了两次resolve/reject方法
      if (this.status === PENDING) {
        this.status = FULFILLED;
        this.value = value;
      }
    };

    //失败方法
    let reject = (reason) => {
      // 状态为 PENDING 时才可以更新状态，防止 executor 中调用了两次 resovle/reject 方法
      if (this.status === PENDING) {
        this.status = REJECTED;
        this.reason = reason;
      }
    };

    try {
      //立即执行,将resolve和reject
      executor(resolve, reject);
    } catch (error) {
      //发生异常时执行失败逻辑
      reject(error);
    }
  }
  //包含一个then方法,并接收两个参数onFulfilled,onRejected
  then(onFulfilled, onRejected) {
    if (this.status === FULFILLED) {
      onFulfilled(this.value);
    }
    if (this.status === REJECTED) {
      onRejected(this.reason);
    }
  }
}
const promise = new Promise((resolve, reject) => {
  resolve('成功');
}).then(
  (data) => {
    console.log('success', data)
  },
  (err) => {
    console.log('faild', err)
  }
)
```

创建一个Promise类,给构造函数传入一个执行器函数(executeor)

设置初始化状态为pendding,成功状态的值value为undefined,失败状态的值reason为un	defined

添加成功方法resolve和失败方法reject

在对应的方法中更新状态和对应的值

在try中调用executor函数,传入resolve和reject

catch中捕获executor执行错误,执行reject方法

添加then方法根据状态执行对应的回调函数



### 异步功能实现

```js
//三个状态
const PENDING = "PENDING";
const FULFILLED = "FULFILLED";
const REJECTED = "REJECTED";

class Promise {
  constructor(executor) {
    //默认状态为PENDING
    this.status = PENDING;
    //存放成功状态的值,默认为undefined
    this.value = undefined;
    //存放失败状态的值,默认为undefined
    this.reason = undefined;

    //存放成功的回调
    this.onResolvedCallbacks = [];
    //存放失败的回调
    this.onRejectedCallbacks = []

    //成功方法
    let resolve = (value) => {
      //状态为PENDING时才可以更新状态,防止executor中调用了两次resolve/reject方法
      if (this.status === PENDING) {
        this.status = FULFILLED;
        this.value = value;
        //依次将对应的函数执行
        this.onResolvedCallbacks.forEach(fn => fn())
      }
    };

    //失败方法
    let reject = (reason) => {
      // 状态为 PENDING 时才可以更新状态，防止 executor 中调用了两次 resovle/reject 方法
      if (this.status === PENDING) {
        this.status = REJECTED;
        this.reason = reason;
        //依次执行对应的函数
        this.onRejectedCallbacks.forEach(fn => fn())
      }
    };

    try {
      //立即执行,将resolve和reject
      executor(resolve, reject);
    } catch (error) {
      //发生异常时执行失败逻辑
      reject(error);
    }
  }
  //包含一个then方法,并接收两个参数onFulfilled,onRejected
  then(onFulfilled, onRejected) {
    if (this.status === FULFILLED) {
      onFulfilled(this.value);
    }
    if (this.status === REJECTED) {
      onRejected(this.reason);
    }
    if(this.status === PENDING){
    //如果promise的状态为PENDING,需要将onFulfilled和onRejected函数存放起来,等待状态确认后再依次执行
      this.onResolvedCallbacks.push(() => {
        onFulfilled(this.value)
      })
      this.onRejectedCallbacks.push(() => {
        onRejected(this.reason)
      })
    }
  }
}
const promise = new Promise((resolve, reject) => {
  setTimeout(() => {
    resolve('成功');
  },1000);
}).then(
  (data) => {
    console.log('success', data)
  },
  (err) => {
    console.log('faild', err)
  }
)

```

构造函数中添加成功回调和失败回调队列

在对应的方法中执行对应队列中的回调

在then中添加判断状态为pending时,将成功回调和失败回调放入对应的队列中

当executor中的异步任务执行完毕,调用成功或者失败方法

在方法中就可以执行之前存入的回调

### then 的链式调用&值穿透特性(promiseA+完整版)

```js
//三个状态
const PENDING = "PENDING";
const FULFILLED = "FULFILLED";
const REJECTED = "REJECTED";

const resolvePromise = (promise2, x, resolve, reject) => {
  //自己等待自己完成是错误实现,用一个类型错误结束掉promise
  if (promise2 === x) {
    return reject(
      new TypeError("Chaining cycle detected for promise #<Promise>")
    );
  }
  //只能调用一次
  let called;
  //后续条件要严格判断,保证代码能和别的库一起使用
  if ((typeof x === "object" && x != null) || typeof x === "function") {
    try {
      let then = x.then;
      if (typeof then === "function") {
        then.call(
          x,
          (y) => {
            // 根据promise的状态决定是成功还是失败
            if (called) return; //只调用一次
            called = true;
            //递归解析(因为promise中可能还有promise)
            resolvePromise(promise2, y, resolve, reject);
          },
          (r) => {
            //只要失败就reject
            if (called) return;
            called = true;
            reject(r);
          }
        );
      } else {
        // 如果x.then是个普通值就直接返回resolve作为结果
        resolve(x);
      }
    } catch (e) {
      if (called) return;
      called = true;
      reject(e);
    }
  } else {
    // 如果x.then是个普通值就直接返回resolve作为结果
    resolve(x);
  }
};

class Promise {
  constructor(executor) {
    //默认状态为PENDING
    this.status = PENDING;
    //存放成功状态的值,默认为undefined
    this.value = undefined;
    //存放失败状态的值,默认为undefined
    this.reason = undefined;

    //存放成功的回调
    this.onResolvedCallbacks = [];
    //存放失败的回调
    this.onRejectedCallbacks = [];

    //成功方法
    let resolve = (value) => {
      //状态为PENDING时才可以更新状态,防止executor中调用了两次resolve/reject方法
      if (this.status === PENDING) {
        this.status = FULFILLED;
        this.value = value;
        //依次将对应的函数执行
        this.onResolvedCallbacks.forEach((fn) => fn());
      }
    };

    //失败方法
    let reject = (reason) => {
      // 状态为 PENDING 时才可以更新状态，防止 executor 中调用了两次 resovle/reject 方法
      if (this.status === PENDING) {
        this.status = REJECTED;
        this.reason = reason;
        //依次执行对应的函数
        this.onRejectedCallbacks.forEach((fn) => fn());
      }
    };

    try {
      //立即执行,将resolve和reject
      executor(resolve, reject);
    } catch (error) {
      //发生异常时执行失败逻辑
      reject(error);
    }
  }
  //包含一个then方法,并接收两个参数onFulfilled,onRejected
  then(onFulfilled, onRejected) {
    //解决onFufilled,onRejected没有传值的问题
    onFulfilled = typeof onFulfilled === "function" ? onFulfilled : (v) => v;
    //因为错误的值要让后面访问到,所以这里也要抛出一个错误,不然会在之后then的resolve中捕获
    onRejected =
      typeof onRejected === "function"
        ? onRejected
        : (err) => {
            throw err;
          };

    //每次调用then返回一个新的promise
    let promise2 = new Promise((resolve, reject) => {
      if (this.status === FULFILLED) {
        setTimeout(() => {
          //这里模拟异步
          try {
            let x = onFulfilled(this.value);
            //x可能是一个promise
            resolvePromise(promise2, x, resolve, reject);
          } catch (err) {
            reject(err);
          }
        }, 0);
      }
      if (this.status === REJECTED) {
        setTimeout(() => {
          try {
            let x = onRejected(this.reason);
            //x可能为promise
            resolvePromise(promise2, x, resolve, reject);
          } catch (err) {
            reject(err);
          }
        }, 0);
      }
      if (this.status === PENDING) {
        this.onResolvedCallbacks.push(() => {
          setTimeout(() => {
            try {
              let x = onFulfilled(this.value);
              resolvePromise(promise2, x, resolve, reject);
            } catch (e) {
              reject(e);
            }
          }, 0);
        });

        this.onRejectedCallbacks.push(() => {
          setTimeout(() => {
            try {
              let x = onRejected(this.reason);
              resolvePromise(promise2, x, resolve, reject);
            } catch (e) {
              reject(e);
            }
          }, 0);
        });
      }
    });
    return promise2;
  }
}
const promise = new Promise((resolve, reject) => {
  reject('失败');
}).then().then().then(data=>{
  console.log(data);
},err=>{
  console.log('err',err);
})

```





