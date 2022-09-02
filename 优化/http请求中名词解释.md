![在这里插入图片描述](E:\front_learn\note\image\1460000037788872.png)

- Queueing: 在请求队列中的时间。
- Stalled: 从TCP 连接建立完成，到真正可以传输数据之间的时间差，此时间包括代理协商时间。
- Proxy negotiation: 与代理服务器连接进行协商所花费的时间。
- DNS Lookup: 执行DNS查找所花费的时间，页面上的每个不同的域都需要进行DNS查找。
- Initial Connection / Connecting: 建立连接所花费的时间，包括TCP握手/重试和协商SSL。
- SSL: 完成SSL握手所花费的时间。
- Request sent: 发出网络请求所花费的时间，通常为一毫秒的时间。
- Waiting(TFFB): **TFFB 是发出页面请求到接收到应答数据第一个字节的时间**。
- **Content Download**: 接收响应数据所花费的时间。

真正下载数据的时间占比为 `13.05 / 204.16 = 6.39%`