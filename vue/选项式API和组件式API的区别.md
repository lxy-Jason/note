选项式(Options API)就是vue2中使用的data,computed,methods等对象,将对应的内容放在对应的对象中

组件式(Component API)vue3推荐使用,将代码统一写在setup函数中

### 逻辑组织和复用

选项式API会导致一个功能的实现的不同部分放在不同的options里,比如data中定义响应式数据

methods中写方法,这样就将一个功能造成了割裂和碎片化

当一个项目太大,代码量很大的时候,这种写法会导致代码可读性下降

而使用选项式API就没有这个问题,可以将功能相关代码都放在一起,方便阅读

### 全是选项式的好处

- 都是函数的形式,有更好的类型推断

- 对`tree shaking`友好,代码更容易压缩

- 不需要使用this,减少this指向不明的情况

  