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

#### Headers

一个JSON对象,描述JWT的元数据

```JSON
{
  "alg": "HS256",
  "typ": "JWT"
}
```

`alg`属性表示签名的算法(algorithm),默认是HMAC SHA256(写成HS256)

`typ`属性表示这个令牌(token)的类型,JWT令牌统一写JWT

#### payload

也是一个JSON对象,用来存放实际需要传递的数据,JWT规定了7个官方字段

- iss (issuer)：签发人
- exp (expiration time)：过期时间
- sub (subject)：主题
- aud (audience)：受众
- nbf (Not Before)：生效时间
- iat (Issued At)：签发时间
- jti (JWT ID)：编号

除了官方字段,这里可以自定义字段,例如:

```json
{
  "sub": "1234567890",
  "name": "John Doe",
  "admin": true
}
```

**注意,JWT默认是不加密的,不要把重要信息放在这里**

#### Signature

这是对前两部分的签名,防止数据篡改

首先,需要指定一个密钥(secret),这个密钥只有服务端才知道

然后,使用Headers中指定的签名算法(默认是HS256),按下面的公式产生签名

```
HMACSHA256(
  base64UrlEncode(header) + "." +
  base64UrlEncode(payload),
  secret)
```

### base64URL

JWT作为一个token有些场合可能会放到URL中

Base64有三个字符`+` `/` `=`,在URL中有特殊意义,所以要被替换掉

`=`被省略,`+`替换成`-` `/`替换成_

其他部分和base64编码一致

### JWT的使用方法

客户端收到服务端返回的JWT,可以存在Cookie或者localStorage中

之后每次请求都要带上这个JWT

可以放在cookie中自动发送,但是不能跨域

更好的办法是放到headers的`Authorization`字段中

还有就是跨域时直接放post请求的数据体中







http://www.ruanyifeng.com/blog/2018/07/json_web_token-tutorial.html