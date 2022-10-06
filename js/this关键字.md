`this`关键字是函数运行时自动生成的一个内部对象,只能在函数内部使用,**总是指向调用它的对象**

### 绑定规则

根据不同的使用场合,`this`有不同的值

#### 默认绑定

在非严格模式下,默认绑定到全局对象,浏览器中是window,nodejs中是global

在严格模式下,this会绑定到`undefined`

#### 隐式绑定

函数作为某个对象的方法调用,此时函数中的`this`就指向这个对象

```js
function test() {
  console.log(this.x);
}

var obj = {};
obj.x = 1;
obj.m = test;

obj.m(); // 1
```

```js
var o = {
    a:10,
    b:{
        fn:function(){
            console.log(this.a); //undefined
        }
    }
}
o.b.fn();
```

这里this指向的是`b`这个对象,这个对象上并没`a`属性

```js
var o = {
    a:10,
    b:{
        a:12,
        fn:function(){
            console.log(this.a); //undefined
            console.log(this); //window
        }
    }
}
var j = o.b.fn;
j(); //相当于window.j()
```

注意函数是对象,是引用类型

这是就是全局中的`j`变量引用了`fn`函数

调用的时候相当于在全局中调用`fn`,所以`this`指向`window`

#### new绑定

通过构造函数`new`关键字生成的一个实例对象,此时函数中的`this`指向这个实例对象

```js
function test() {
　this.x = 1;
}

var obj = new test();
obj.x // 1
```

如果构造函数有返回值,也就是有`return`关键字

如果返回的是一个简单类型或者是`null`,则`this`依然指向实例对象

如果返回值是一个对象,则`this`指向为这个对象

#### 显式修改

`apply(),call(),bind()`三个函数方法可以修改函数的调用对象

其中第一个参数就是`this`指向的对象

```js
var x = 0;
function test() {
　console.log(this.x);
}

var obj = {};
obj.x = 1;
obj.m = test;
obj.m.apply(obj) // 1
```

#### 箭头函数中的`this`

箭头函数中的`this`,默认绑定的是函数所在对象的外层对象

```js
const obj = {
  sayThis: () => {
    console.log(this);
  }
};

obj.sayThis(); // window 因为 JavaScript 没有块作用域，所以在定义 sayThis 的时候，里面的 this 就绑到 window 上去了

```



















































