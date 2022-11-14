```js
Promise.prototype.myFinally = function (cb) {
  return this.then(
    (value) => {
      Promise.resolve(cb()).then(() => value);
    },
    (err) => {
      Promise.resolve(cb()).then(() => {
        throw err;
      });
    }
  );
};

new Promise((resolve, reject) => {
  setTimeout(() => resolve("result"), 1000)
})
  .then(result => console.log(result))
  .myFinally(() => console.log("Promise end"))

```

