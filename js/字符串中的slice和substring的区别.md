**这两个正常使用上功能基本一样**



substring:会根据两个参数的大小自动判断,哪个是起始位置,哪个是结束位置

slice:没有这个特性

```js
let str = '123456789'

let test = str.substring(1, 4)
console.log(test); //234

test = str.substring(4, 1)
console.log(test); //234

test = str.slice(1,4)
console.log(test); //234

test = str.slice(4, 1)
console.log(test); //这个是空
```



substring:当参数小于0时,就按0处理

slice:当参数小于0时,从后面往前面数

```js
let str = '123456789'

let test = str.substring(1, -4)//相当于str.substring(0,1)
console.log(test); //1

test = str.slice(1,-4)
console.log(test); //2345
```

