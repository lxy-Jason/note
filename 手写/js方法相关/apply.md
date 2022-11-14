```js
Function.prototype.myApply = function(context,arr){
  context = Object(context) || window; //原始类型包装
  context.fn = this;
  const result = context.fn(...arr)
  delete context.fn
  return result;
}

var foo = {
  value:1
}

function bar(name,age){
  console.log(name);
  console.log(age);
  console.log(this.value);
}
bar.myApply(foo,["Jason",20])
```

### es5

```js
Function.prototype.myApply = function (context, arr) {
  context = Object(context) || window;
  context.fn = this;
  var result;
  if (!arr) {
    result = context.fn();
  } else {
    var args = [];
    for (var i = 0; i <= arr.length; i++) {
      args.push("arr[" + i + "]");
    }
    result = eval("context.fn(" + args + ")");
  }
  delete context.fn;
  return result;
};

var foo = {
  value: 1,
};

function bar(name, age) {
  console.log(name);
  console.log(age);
  console.log(this.value);
}
bar.myApply(foo,["Jason",19]);

```

