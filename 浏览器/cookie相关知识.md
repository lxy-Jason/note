### 字段

- key
- value
- domain 指定可以访问cookie的域名,默认情况下，cookie只能在设置它的域名下访问。
- path 可以访问cookie页面路径,默认情况下，cookie只能在设置它的路径下访问。
- expiress/Max-Age 设置过期时间,可以使用expires属性设置一个具体的过期日期，或使用Max-Age属性设置cookie在多少秒后过期。
- size cookie的大小
- HttpOnly 设置js无法操作cookie
- SameSite 设置同源
- secure 设置是否只能通过https来传递

### 设置cookie

1. 设置基本的cookie：

   ```javascript
   document.cookie = "username=John Doe";
   ```

2. 设置带有过期时间的cookie：

   ```javascript
   var expires = new Date();
   expires.setDate(expires.getDate() + 7); // 设置过期时间为7天后
   document.cookie = "username=John Doe; expires=" + expires.toUTCString();
   ```

3. 设置cookie的域和路径：

   ```javascript
   document.cookie = "username=John Doe; domain=example.com; path=/";
   ```

4. 设置安全标志和HttpOnly标志：

   ```javascript
   document.cookie = "username=John Doe; secure; HttpOnly";
   ```

设置cookie时需要注意一些限制和规则，例如在名称和值中不能包含特殊字符（如分号、逗号和空格），并且域和路径必须与当前页面的域和路径匹配。此外，设置cookie时需要遵循浏览器对cookie的限制和安全策略。

### cookie可以跨域吗,怎么跨域

默认情况是不可以跨域的,就是说如果没有使用cookie时其他接口就是跨域的情况,即使设置了cors也不会携带cookie

 要实现cookie跨域,需要设置一个字段`withCredentials`

fetch:

```js
fetch('http://baidu.com:3000', {
    // ...
	credentials: true
})
```

xhr api

```js
var invocation = new XMLHttpRequest();
var url = 'http://bar.other/resources/credentialed-content/';

function callOtherDomain(){
  if(invocation) {
    invocation.open('GET', url, true);
    invocation.withCredentials = true; // 带上cookie
    invocation.onreadystatechange = handler;
    invocation.send();
  }
}
```

除此之外,注意SameSite 设置成none,否则不能跨域