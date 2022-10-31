Generator生成器

Generator函数是es6提供的一种异步编程解决方案

`Generator` 函数会返回一个**遍历器对象**，即具有`Symbol.iterator`属性，并且返回给自己

```js
function* gen(){
  // some code
}
var g = gen();
g[Symbol.iterator]() === g
// true
```

通过这一点可以将没有遍历接口的原生对象进行遍历

```javascript
function* objectEntries(obj) {
  let propKeys = Reflect.ownKeys(obj);

  for (let propKey of propKeys) {
    yield [propKey, obj[propKey]];
  }
}

let jane = { first: 'Jane', last: 'Doe' };

for (let [key, value] of objectEntries(jane)) {
  console.log(`${key}: ${value}`);
}
// first: Jane
// last: Doe
```



Generator最特别的地方在于可以主动暂停函数的执行

通过`yield`关键字可以暂停`generator`函数返回的遍历器对象的状态

通过next()才能遍历到下一个状态

**next方法执行后返回一个对象,对象中有value和done两个属性**

通过`next`方法才会遍历到下一个内部状态，其运行逻辑如下：

- 遇到`yield`表达式，就暂停执行后面的操作，并将紧跟在`yield`后面的那个表达式的值，作为返回的对象的`value`属性值。
- 下一次调用`next`方法时，再继续往下执行，直到遇到下一个`yield`表达式
- 如果没有再遇到新的`yield`表达式，就一直运行到函数结束，直到`return`语句为止，并将`return`语句后面的表达式的值，作为返回的对象的`value`属性值。
- 如果该函数没有`return`语句，则返回的对象的`value`属性值为`undefined`

通过这一点可以进行异步编程

```javascript
function* helloWorldGenerator() {
  yield 'hello';
  yield 'world';
  return 'ending';
}
var hw = helloWorldGenerator();
hw.next()
// { value: 'hello', done: false }

hw.next()
// { value: 'world', done: false }

hw.next()
// { value: 'ending', done: true }

hw.next()
// { value: undefined, done: true }
```

`done`用来判断是否存在下个状态，`value`对应状态值

`yield`表达式本身没有返回值，或者说总是返回`undefined`

通过调用`next`方法可以带一个参数，该参数就会被当作上一个`yield`表达式的返回值

**第一次next传参是没用的，只有从第二次开始next传参才有用**

```javascript
function* foo(x) {
  var y = 2 * (yield (x + 1));
  var z = yield (y / 3);
  return (x + y + z);
}

var a = foo(5);
a.next() // Object{value:6, done:false} 第一次执行,执行到第一个yield
a.next() // Object{value:NaN, done:false} 这里返回undefined 所以y = 2 * undefiend
a.next() // Object{value:NaN, done:true} 最后一次执行完return

var b = foo(5);
b.next() // { value:6, done:false }
b.next(12) // { value:8, done:false } y = 2 * 12
b.next(13) // { value:42, done:true } 
```