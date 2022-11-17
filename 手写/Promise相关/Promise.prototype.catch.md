```js
Promise.prototype.myCatch = function(onRejected){
  return this.then(null,onRejected)
}
let p = new Promise((resolve,reject) => {
  reject(1)
})
p.myCatch(err => {
  console.log(err);
})
```

就是把then方法封装一下