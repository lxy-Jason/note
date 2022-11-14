```js
function myTypeof(params) {
  const type = Object.prototype.toString
    .call(params)
    .slice(8, -1)
    .toLowerCase();
  const map = {
    number: true,
    string: true,
    boolean: true,
    undefined: true,
    bigint: true,
    symbol: true,
    function: true,
  };
  return map[type] ? type : "object";
}
// 测试用例
console.log(myTypeof(1));
console.log(myTypeof(""));
console.log(myTypeof(false));
console.log(myTypeof(null));
console.log(myTypeof(undefined));
console.log(myTypeof(10n)); // bigint
console.log(myTypeof(Symbol()));
console.log(myTypeof(() => {}));
console.log(myTypeof([]));
console.log(myTypeof({}));
```

从这里可以看出,js手写实现typeof用的是**`Object.prototype.toString.call()`**

并且如果要完成和`typeof`功能一样还需要做后面的限制

