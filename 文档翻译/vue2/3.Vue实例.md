# Vue实例

## 创建Vue实例

每个Vue应用程序都是通过使用Vue函数创建一个新的Vue实例开始的：

```js
var vm = new Vue({
  // options
})
```

尽管与MVVM模式没有严格关联，但Vue的部分设计受其启发。

作为惯例，我们经常使用变量vm（ViewModel的缩写）来指代我们的Vue实例。

当你创建一个Vue实例时，你需要传入一个选项对象。

大部分的指南都描述了如何使用这些选项来创建您所期望的行为。

作为参考，您还可以在API参考中浏览完整的选项列表[API reference](https://v2.vuejs.org/v2/api/#Options-Data).

Vue应用程序使用new Vue创建,由一个根Vue实例组成，可选择地组织为嵌套的可重用组件树。

例如，一个待办事项应用的组件树可能如下所示：

```
Root Instance
└─ TodoList
   ├─ TodoItem
   │  ├─ TodoButtonDelete
   │  └─ TodoButtonEdit
   └─ TodoListFooter
      ├─ TodosButtonClear
      └─ TodoListStatistics
```

我们稍后会详细讨论组件系统。现在只需要知道，所有的Vue组件也是Vue实例，因此接受相同的选项对象（除了一些特定于根实例的选项）。

## [Data and Methods](https://v2.vuejs.org/v2/guide/instance#Data-and-Methods)

当创建一个Vue实例时，它会将data对象中的所有属性添加到Vue的响应系统中。

当这些属性的值发生变化时，视图将会“响应”，更新以匹配新的值。

```js
// data对象
var data = { a: 1 }

// data对象添加到Vue实例中
var vm = new Vue({
  data: data
})

// 获取实例上的属性a
// 原始data对象上的a
vm.a == data.a // => true

// 实例上设置属性
// 也会影响原始data对象
vm.a = 2
data.a // => 2

// ... and vice-versa(反之亦然)
data.a = 3
vm.a // => 3
```

当这个数据发生变化时，视图将重新渲染。需要注意的是，只有在实例创建时存在的data属性才具有响应性。

这意味着如果您添加了一个新的属性，比如：

```js
vm.b = 'hi'
```

如果你知道以后会需要一个属性，但它一开始是空的或不存在的，那么你需要设置一些初始值。例如：

```js
data: {
  newTodoText: '',
  visitCount: 0,
  hideCompletedTodos: false,
  todos: [],
  error: null
}
```

唯一的例外是使用`Object.freeze()`，它可以防止现有属性被修改，这也意味着响应式系统无法跟踪变化。

```js
var obj = {
  foo: 'bar'
}

Object.freeze(obj)

new Vue({
  el: '#app',
  data: obj
})
```

```vue
<div id="app">
  <p>{{ foo }}</p>
  <!-- `foo`不会再更新! -->
  <button v-on:click="foo = 'baz'">Change it</button>
</div>
```

除了数据属性之外，Vue实例还暴露了许多有用的实例属性和方法。

通过以`$`为前缀，以区别于用户定义的属性。例如：

```js
var data = { a: 1 }
var vm = new Vue({
  el: '#example',
  data: data
})

vm.$data === data // => true
vm.$el === document.getElementById('example') // => true

// $watch 是实例方法
vm.$watch('a', function (newValue, oldValue) {
    // vm.a 修改时,这个回调函数会被调用
})
```

将来，您可以查阅API参考手册以获取实例属性和方法的完整列表。

## 实例生命周期钩子

每个Vue实例在创建时都会经历一系列的初始化步骤 - 例如，它需要设置数据观察、编译模板、将实例挂载到DOM上，并在数据变化时更新DOM。

沿途，它还运行称为生命周期钩子的函数，使用户有机会在特定阶段添加自己的代码。

例如，`created`钩子可以用于在实例创建后运行代码。

```js
new Vue({
  data: {
    a: 1
  },
  created: function () {
    // `this` 指向Vue实例
    console.log('a is: ' + this.a)
  }
})
// => "a is: 1"
```

此外，还有其他钩子函数会在实例的生命周期的不同阶段被调用，例如 mounted、updated 和 destroyed。所有的生命周期钩子函数都会在调用它的 Vue 实例上下文中被调用。

>不要在选项属性或回调中使用箭头函数，例如 created: () => console.log(this.a) 或 vm.$watch('a', newValue => this.myMethod())。
>
>由于箭头函数没有自己的 this，this 将被视为其他变量，并通过父级作用域进行词法查找，直到找到为止。
>
>这通常会导致错误，如 Uncaught TypeError: Cannot read property of undefined 或 Uncaught TypeError: this.myMethod is not a function。

## 生命周期图

下面是一个实例生命周期的图表。你现在不需要完全理解其中发生的一切，但随着你学习和构建更多内容，它将成为一个有用的参考。

<img src="image/lifecycle.png" alt="The Vue Instance Lifecycle" style="zoom:50%;" />
