如果传递的对象不仅仅有接口定义的属性，这时候可以使用：

- 类型推断

```text
interface User {
    name: string
    age: number
}

const getUserName = (user: User) => user.name
getUserName({color: 'yellow'} as User)
```

- 给接口添加字符串**索引签名**

```ts
interface User {
    name: string
    age: number
    [propName: string]: any;
}
```

**接口还能继承**