### 新增的构造函数方法

- from() 将类数组和可迭代`iterable`对象转化成数组
- of() 将一组参数转化成数组,不提供参数时返回空数组

### 新增的常用实例方法

- find(),findIndex() 寻找数组中第一个符合条件的元素
- fill() 填充数组元素
- entries(),keys(),values() 分别是对`键值对`的遍历,`键名`的遍历和`键值`遍历
- includes() 判断数组中是否存在给定值
- flat() 数组扁平化 默认拉平一层,参数指定拉平层数,可以是`infinity`

### 扩展运算符的使用

将数组转化成用逗号分隔的参数列表

```js
console.log(...[1, 2, 3])
// 1 2 3
```

将类数组和可迭代对象转成数组

```js
let nodeList = document.querySelectorAll('div');
let array = [...nodeList];

let map = new Map([
  [1, 'one'],
  [2, 'two'],
  [3, 'three'],
]);

let arr = [...map.keys()]; // [1, 2, 3]
```

数组的复制与合并

```js
const a1 = [1, 2];
const a2 = [...a1]
const a3 = [...a1,...a2]
```

**扩展运算符是浅拷贝**

```js
const arr1 = ['a', 'b',[1,2]];
const arr2 = ['c'];
const arr3  = [...arr1,...arr2]
arr1[2][0] = 9999 // 修改arr1里面数组成员值
console.log(arr[3]) // 影响到arr3,['a','b',[9999,2],'c']
```

















