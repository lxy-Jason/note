```js
function promiseAll(args) {
  return new Promise((resolve, reject) => {
    const result = [];
    let count = 0; //promise总数
    let fullfilledCount = 0; //完成的数量

    for (const item of args) {
      let index = count;
      count++;

      //包一层,用来兼容非promise的情况
      Promise.resolve(item)
        .then((res) => {
          result[index] = res;
          fullfilledCount++;

          if (fullfilledCount === count) {
            resolve(result);
          }
        })
        .catch((err) => {
          reject(err);
        });
    }
    if (count === 0) {
      //处理空 iterator 的情况
      resolve(result);
    }
  });
}
```

测试

```js
let p1 = new Promise((resolve) => {
  resolve(1);
});
let p2 = new Promise((resolve, reject) => {
  reject(2);
});
let p3 = new Promise((resolve, reject) => {
  resolve(3);
});

promiseAll([p1, p2, p3])
  .then((res) => {
    console.log(res);
  })
  .catch((err) => {
    console.log(err);
  });
```



