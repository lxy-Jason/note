### 响应式原理不同

vue2是通过`Object.defineProperty`实现,数组需要通过重写原型方法的方式才能监听到元素修改

vue3通过`proxy`实现,

使用proxy的优势

- definproperty只能监听某个属性,不能对全对象进行监听,只能遍历所有属性进行监听,
- `proxy`可以直接监听对象的修改
- 也就可以监听数组的修改,不用重写方法

### 多个根节点

- vue2组件只能有一个根节点
- vue3组件可以多个根节点

Vue 2使用的是基于选项的API（Options API），根组件是通过Vue实例的`el`选项来指定的。

Composition API允许我们使用`createApp`函数创建一个应用实例，并通过`mount`方法将根组件挂载到指定的元素上。

在Vue 3中，我们可以使用`createApp`创建多个应用实例，每个应用实例可以有自己的根组件，然后通过`mount`方法将不同的根组件挂载到不同的元素上。这样就实现了多个根组件的功能。

```js
// 创建第一个根组件
const app1 = createApp(RootComponent1);
app1.mount('#app1');

// 创建第二个根组件
const app2 = createApp(RootComponent2);
app2.mount('#app2');

```



### api类型不同

vue2是选项式api,选项式api在代码中分割了不同属性,data,methods,computed

vue3提供了组合式api,相比于选项式api,代码更加整洁和便利

### diff算法

vue3优化了diff算法,不再像vue2那样对比所有dom元素

对比只在同一层dom元素之间

还不完善

### 创建Vue实例上的不同

vue2是通过new Vue() 构造函数的方式来实现,整个项目是共享一个Vue构造函数对象的,这样容易出现污染问题,

还有可能只是一个组件使用某个插件,但是会直接挂载在Vue原型上,这也是不合理的一个地方

vue3通过createApp方法(工厂模式)可以返回一个提供应用上下文的实例,不同实例注册的组件无法在其他实例下使用

这样更适合大型的开发环境中使用,不同的开发人员可以独立使用不同的实例

### 更好的TypeScript支持

Vue 3对TypeScript的支持更加完善。Vue 3使用了TypeScript重新编写，提供了更好的类型推导和类型检查，使得在使用TypeScript开发Vue应用时更加友好和高效。

### 更小的包体积

Vue 3通过优化和重构，减小了包的体积。Vue 3的核心库体积相对较小，同时还引入了Tree-shaking机制，可以更好地消除未使用的代码，减少最终打包的体积。

### 静态模板编译

vue2时,在html文件中使用vue是运行时编译,就是浏览器执行时才进行编译

在.vue文件中则是构建时编译,也就是静态模板编译,将模板编译成render函数,在浏览器中就可以直接执行

在vue3中,html文件也是构建时编译了,也就是静态模板编译
