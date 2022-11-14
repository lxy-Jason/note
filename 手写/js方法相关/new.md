```js
function myNew(func,...args) {
  //创建一个新对象
  const obj = {};
  //将新对象的原型指向构造函数的原型
  obj.__proto__ = func.prototype
  //将构造函数的this指向新对象
  let result = func.apply(obj,args)
  //根据返回值判断
  return result instanceof Object ? result : obj
}
function Person(name, age) {
  this.name = name;
  this.age = age;
}
Person.prototype.say = function () {
  console.log(this.name)
}

let p = myNew(Person, "huihui", 123)
console.log(p) // Person {name: "huihui", age: 123}
p.say() // huihui
```

