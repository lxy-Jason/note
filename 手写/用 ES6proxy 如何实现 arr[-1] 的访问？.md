```js
function createArray(...element){
  let handler = {
    get(target,propKey,receiver){
      let index = Number(propKey);
      if(index < 0){
        propKey = String(target.length + index);
      }
      return Reflect.get(target,propKey,receiver);
    }
  };
  let target = [];
  target.push(...element);
  return new Proxy(target,handler);
}
let arr = createArray(1,2,3);
console.log(arr[-1]);
```

这里arr[-1]就是返回数组的最后一个