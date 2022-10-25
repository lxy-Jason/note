```js
Function.prototype.myCall =  function(context){
  context = context || window;
  context.fn = this; //fun

  let args = [];
  for(let i = 1, len = arguments.length; i < len; i++){
    args.push(`arguments[${i}]`)
  }
  let result = eval(`context.fn(${args})`) //这里实际传入的是[ 'arguments[1]', 'arguments[2]' ]
  //不是很理解
  delete context.fn
  return result //这个是fun的返回值,fun没有返回值就是undefined
}
let test = {
  name:"Jason",
  age:20
}
function fun(a){
  console.log(this.name,this.age);
  return a
}
fun.myCall(test,1)
```

