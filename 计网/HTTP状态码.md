1. [信息响应](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Status?qs=http#信息响应) (`100`–`199`)
2. [成功响应](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Status?qs=http#成功响应) (`200`–`299`)
3. [重定向消息](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Status?qs=http#重定向消息) (`300`–`399`)
4. [客户端错误响应](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Status?qs=http#客户端错误响应) (`400`–`499`)
5. [服务端错误响应](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Status?qs=http#服务端错误响应) (`500`–`599`)



### 常问的具体状态码

- 100 continue 继续
- 101 切换协议

- 200 ok(成功)
- 201 created (请求成功,并且创建了一个新资源,用于post或者put请求的响应)
- 204 No centent (没有内容,但头部字段可能有用)
- 301 Moved Parmanently(永久重定向)
- 302 (临时重定向)
- 304 Not Modified (未修改)
- 307 (临时重定向)
- 308 (永久重定向)
- 400 Bad Request (客户端错误)
- 401 (未授权)
- 403 (禁止访问)
- 404 (资源未找到)
- 405 Methods Not Allowed (请求方法不允许)
- 500 (服务端错误)
- 502  (网关错误)
- 504 (网关超时)



### 301 302 307 308的区别

简单来说就是历史原因在301和302的实现上有问题,所以后面添加307和308

主要区别在于前两者在重定向时可能会改变请求方法,post改成get这种情况

后两者就不允许这种情况发生,是post重定向的请求方法还得是post