### 关键点

- constructor是一个构造函数方法,创建对象时自动调用该方法
- constructor 默认存在,可以省略,程序依然可以调用
- this指的是实例化对象
- 类中声明的方法不用也不能加关键字
- 方法之间不需要使用逗号分隔

- class本质上是一个函数,自身指向的就是构造函数

```js
class Cat{

}
console.log(typeof Cat === "function"); //true
console.log(Cat.prototype.constructor === Cat); //true
```

- class就相当于构造函数的另一种写法
- class也可以通过prototype去添加类方法
- class实例对象同样有`__proto__`属性指向原型对象

### 实例属性和原型属性

实例属性: 定义在constructor中,通过this.xxx = xxx;

原型属性: 除了实例属性都是原型属性,直接在类中定义

`hasOwnProperty`方法可以用来判断是实例属性还是原型属性

### class构造函数的区别

- 类必须要通过new调用,否则会报错.构造函数可以当普通函数使用
- 类内部所有定义的方法,都是不可枚举的(包括内部定义的静态方法)
- 类的静态方法也可以被子类继承
- 