- boolean
- number
- string
- undefined
- null
- array
- tuple (元组)
- enum(枚举)
- any(任何类型)
- void
- never
- object

### tuple

元祖类型，允许表示一个已知元素数量和类型的数组，各元素的类型不必相同

```tsx
let tupleArr:[number, string, boolean];
tupleArr = [12, '34', true]; //ok
typleArr = [12, '34'] // no ok
```

**赋值的类型、位置、个数需要和定义（声明）的类型、位置、个数一致**

默认情况下`null`和`undefined`是所有类型的子类型， 就是说你可以把 `null`和 `undefined`赋值给 `number`类型的变量

```tsx
let num:number | undefined; // 数值类型 或者 undefined
console.log(num); // 正确
num = 123;
console.log(num); // 正确
```

但是`ts`配置了`--strictNullChecks`标记，`null`和`undefined`只能赋值给`void`和它们各自

### never

`never`是其他类型 （包括`null`和 `undefined`）的子类型，可以赋值给任何类型，代表从不会出现的值

但是没有类型是 never 的子类型,这意味着声明为never的变量只能被never类型赋值

never类型一般用于指定那些总是会抛出异常,无限循环

```ts
let a:never;
a = 123; // 错误的写法

a = (() => { // 正确的写法
  throw new Error('错误');
})()

// 返回never的函数必须存在无法达到的终点
function error(message: string): never {
    throw new Error(message);
}
```





