### 相同的作用

都是改变函数执行时的上下文,也就是改变函数的`this`指向

第一个参数是`this`指向,如果没有这个参数或者参数为undefined或者null,默认指向全局window

区别

**bind和call,apply的区别**

call,apply改变this指向之后会立即调用函数

但bind不会立即调用,而是返回`this`指向改变后的新函数

bind支持参数分多次传入,call和apply则是一次性传入

**call和apply的区别**

功能上是一致的

不同之处在参数上,apply的参数可以支持数组类型

call的参数必须要一个个传入,不支持数组

