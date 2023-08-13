- 创建一个新对象
- 将对象与构造函数通过原型链连接起来
- 将构造函数中的`this`绑定到新建对象obj上
- 根据构造函数返回类型做判断,如果是原始值则被忽略,如果是返回对象,需要正常处理

### 手写new

```js
function myNew(func,...args) {
  //创建一个新对象
  const obj = {};
  //将新对象的原型指向构造函数的原型
  obj.__proto__ = func.prototype
  //将构造函数的this指向新函数
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

