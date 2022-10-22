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

### api类型不同

vue2是选项式api,选项式api在代码中分割了不同属性,data,methods,computed

vue3提供了组合式api,相比于选项式api,代码更加整洁和便利

### diff算法

vue3优化了diff算法,不再像vue2那样对比所有dom元素

对比只在同一层dom元素之间

还不完善

### vue3升级的地方

- 更好ts支持
- 打包更科学,使用`tree shaking`将没有使用的代码删除,减少打包体积
