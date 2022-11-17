不管成功还是失败,返回第一个完成的

```js
Promise.myRace = function(arr){
  return new Promise((resolve,reject) => {
    for(let item of arr){
      Promise.resolve(item).then(res => {
        resolve(res)
      }).catch(err => {
        reject(err)
      })
    }
  })
}
let p1 = new Promise(resolve => {
  setTimeout(() => {
    resolve(1)
  },100)
})
let p2 = new Promise((resolve,reject) => {
  setTimeout(() => {
    reject(2)
  })
})
let p3 = new Promise((resolve,reject) => {
  setTimeout(() => {
    resolve(3)
  })
})

Promise.myRace([p1,p2,p3]).then(res => {
  console.log(res);
}).catch(err => {
  console.log(err);
})
```

