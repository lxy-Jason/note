### 在vue3中

当它们同时存在于一个节点上时，`v-if` 比 `v-for` 的优先级更高。这意味着 `v-if` 的条件将无法访问到 `v-for` 作用域内定义的变量别名

```js
<!--
 这会抛出一个错误，因为属性 todo 此时
 没有在该实例上定义
-->
<li v-for="todo in todos" v-if="!todo.isComplete">
  {{ todo.name }}
</li>
```

### 在vue2中

v-for的优先级更高,这样v-if是可以拿到v-for中的变量的

但是都说这里存在一个性能问题

当v-for循环的数据量很大时，v-if会在每次循环中进行条件判断，可能导致不必要的性能开销。
