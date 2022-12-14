JSON Web Tokens

一种跨域认证解决方案

特点:数据保存在客户端,每次请求发回服务器

### 原理

服务端认证以后,生成一个JSON对象发回给用户,例如:

```json	
{
  "姓名": "张三",
  "角色": "管理员",
  "到期时间": "2018年7月1日0点0分"
}
```

之后用户与服务端通信时,都要发回这个JSON对象

服务端完全靠这个对象认定用户身份

### 组成

整体是一个字符串,用`.`分成三块

分别是Headers(头部) Payload(负载) Signature(签名)

http://www.ruanyifeng.com/blog/2018/07/json_web_token-tutorial.html