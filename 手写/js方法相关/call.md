### es5版本

```js
Function.prototype.myCall = function(context){
  context = context || window //context为null时指向window
  //首先获取调用call的函数,用this可以获取
  context.fn = this;
  var args = [];
  for(var i = 1, len = arguments.length; i < len; i++){
    args.push('arguments[' + i + ']');
  }
  // 执行后 args为 ["arguments[1]", "arguments[2]", "arguments[3]"]
  //接收函数返回值
  var result = eval('context.fn(' + args + ')')//这里 args 会自动调用 Array.toString() 这个方法。
  delete context.fn;
  return result
}

var foo = {
  value:1
}

function bar(name,age){
  console.log(name);
  console.log(age);
  console.log(this.value);
}
bar.myCall(foo,"Jason",20)
```

### es6版本

```js
Function.prototype.myCall = function(context,...args){
  context = Object(context) || window;

  context.fn = this; //这里的this指向调用的函数,context是我们希望this指向的对象,将context.fn 赋值为调用的函数,因为fn是context对象的一个属性,调用的函数中的this就指向context了
  const result = context.fn(...args)
  delete context.fn;
  return result
}
```

