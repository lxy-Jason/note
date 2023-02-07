```js
function myInstanceof(left,right){
  if(typeof left !== "object" || left === null){
    return false
  }
  //得到left.__proto__指向的对象
  let proto = Object.getPrototypeOf(left);
  while(true){
    if(proto === null){
      return false
    }
    if(proto === right.prototype){
      return true
    }
    proto = Object.getPrototypeOf(proto)
  }
}
console.log(myInstanceof(undefined, String)); // false
console.log(myInstanceof(new String('aaa'), String)); // true
console.log(myInstanceof([], Array)); // true
```

**这里注意如果第二个参数为null应该报错**
