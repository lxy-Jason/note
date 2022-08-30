### secure

当设置为true时,表示创建的Cookie会被以安全的形式向服务端传输,也就是在HTTPS连接中才能传递cookie,如果是http连接就不会传输cookie

可防止cookie信息在传递的过程中泄露

### HttpOnly

设置之后js脚本无法获取cookie信息,有效防范XSS攻击盗取信息的一种方式

### domain

限制域名