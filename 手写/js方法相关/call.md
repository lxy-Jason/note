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

  context.fn = this;
  const result = context.fn(...args)
  delete context.fn;
  return result
}
```

