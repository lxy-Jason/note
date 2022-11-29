### 为什么要call

因为大多数对象都是重写了toString()

不同类型去调用,返回结果不一致

所以通过Object.prototype.toString()调用没有重写之前的toString()

这样返回的格式一致

Object.prototype.toString()返回一个字符串`[object type]`

这里的type是对象的类型

`undefined`和`null`会直接返回对应的`[object Undefined]`和`[object Null]`

其他基本类型会包装成对应的对象

如果对象有`Symbol.toStringTag`属性,这个属性值将作为type

许多内置的对象都有这个属性,不同类型的对象属性值不同

通过toString()返回的值不同就可以区分不同数据类型

自定义的类,如果不自定义一个`Symbol.toStringTag`属性

那么都会返回`[object Object]`