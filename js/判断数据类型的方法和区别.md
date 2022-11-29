typeof用于区分基本数据类型

bigint也可以判断

无法区分object array null



instanceof用于检测构造函数的`prototype`属性是否出现在某个实例的原型链上

主要用于区分Array 和 Object



如果想一次区分所有类型,可以使用`Object.prototype.toString.call()`



