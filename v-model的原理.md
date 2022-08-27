### v-model的原理

是value属性加input事件的语法糖

具体相当于:

- v-bind:value绑定一个变量msg
- @input事件调用时修改msg

### 为什么要proxy中使用reflect

- 只要`Proxy`对象具有的代理方法，`Reflect`对象全部具有，以静态方法的形式存在。这些方法能够执行默认行为，无论`Proxy`怎么修改默认行为，总是可以通过`Reflect`对应的方法获取默认行为。
- 修改某些`Object`方法的返回结果，让其变得更合理。比如，`Object.defineProperty(obj, name, desc)`在无法定义属性时，会抛出一个**错误**，而`Reflect.defineProperty(obj, name, desc)`则会返回`false`。
- 让`Object`操作都变成函数行为。某些`Object`操作是命令式，比如`name in obj`和`delete obj[name]`，而`Reflect.has(obj, name)`和`Reflect.deleteProperty(obj, name)`让它们变成了函数行为。

**`Reflect`对象的操作和`Proxy`对象的操作一一对应，在`Proxy`的拦截操作中，可以直接利用`Reflect`对象直接获取`Proxy`的默认值。**