### 显示转换

程序员自己动手做的类型转换

- Number()

| 原始值    | 转换结果                                                     |
| --------- | ------------------------------------------------------------ |
| Undefined | NaN                                                          |
| null      | 0                                                            |
| String    | 如果由数字和小数点组成就可以转换,否则是NaN; 注意空字符串可以转成0 |
| Symbol    | 报错,TypeError: Cannot convert a Symbol value to a number    |
| Object    | 先调用toPrimitive,转成原始值,再调用toNumber;基本上都是转化成了NaN |

- String()

```js
//注意对象,其他的基本上是啥就转成啥
String({a: 1}) // "[object Object]"
String([1, 2, 3]) // "1,2,3"
```

- Boolean()

| 数据类型  | 为true的值                         | 为false的值 |
| --------- | ---------------------------------- | ----------- |
| string    | 非空字符串                         | 空字符串    |
| number    | 非零数字,包括负数,无穷值(infinity) | 0和NaN      |
| object    | 所有对象除了null                   | null        |
| undefined | 不存在                             | undefined   |

- parseInt(),字符串转整数
- parseFloat(),转浮点数

### 隐式转换

程序自动执行,不是程序员操作的类型转换

一般是两种场景

- 比较运算(`== , != , > , <, if , while`)这些需要布尔值的地方,都是将类型转换成Boolean
- 算术运算(`+ - * % /`)

#### 自动转布尔值

前面提到的比较运算

需要转换成布尔值的场景,系统调用的就是Boolean()

**只需要记转换成`false`的几个值:**

1. undefined
2. null
3. false
4. +0
5. -0
6. NaN
7. "",空字符串



#### 自动转字符串

主要是`+`运算符的位置

一个字符串`+`任何值,都是字符串的拼接

```js
'5' + 1 // '51'
'5' + true // "5true"
'5' + false // "5false"
'5' + {} // "5[object Object]"
'5' + [] // "5"
'5' + function (){} // "5function (){}"
'5' + undefined // "5undefined"
'5' + null // "5null"
1 + '11' // '111'
```

**这里注意,`+`左右只要有一个是字符串类型,都是字符串的拼接**



#### 自动转数字

前面提到的算术运算,基本上都是把类型转换成number

除了前面提到的字符串`+`一个值是转换成字符串,其他都是转number类型

```js
'5' - '2' // 3
'5' * '2' // 10
true - 1  // 0
false - 1 // -1
'1' - 1   // 0
'5' * []    // 0
false / '5' // 0
'abc' - 1   // NaN
null + 1 // 1
undefined + 1 // NaN
```





























