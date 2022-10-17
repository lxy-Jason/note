```js
Array.prototype.myForEach = function(callback,thisArg){
  if(this == null){
    throw new TypeError("this is null or not defined")
  }
  if(typeof callback !== "function"){
    throw new TypeError(callback + "is not a function")
  }
  const O = Object(this) //this是当前的数组
  const len = O.length >>> 0 //无符号右移 0 位
  //是为了保证转换后的值为正整数
  //其实底层做了 2 层转换，第一是非 number 转成 number 类型，第二是将 number 转成 Uint32 类型。
  let k = 0;
  while(k < len){
    if(k in O) { //k是索引
      callback.call(thisArg,O[k],k,O)
    }
    k++
  }
}
let arr = [1,2,3]
arr.myForEach((item,index) => {
  console.log(item,index)
})
```

