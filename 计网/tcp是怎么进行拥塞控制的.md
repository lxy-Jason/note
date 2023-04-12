TCP拥塞控制有三个阶段：慢启动、拥塞避免和拥塞检测。

### 慢启动

慢启动是TCP拥塞控制算法的一部分，它用于探测网络的可用带宽，并平衡网络连接的速度。[1](https://www.keycdn.com/support/tcp-slow-start) 慢启动的过程是这样的：

- 发送方开始向接收方发送一个包含初始拥塞窗口大小（cwnd）的数据包。[1](https://www.keycdn.com/support/tcp-slow-start)
- 接收方收到数据包后，回复一个包含其最大缓冲区大小（rwnd）的确认包。[1](https://www.keycdn.com/support/tcp-slow-start)
- 如果发送方收到确认包，就将cwnd加倍，并发送更多的数据包。[1](https://www.keycdn.com/support/tcp-slow-start) [2](https://developer.mozilla.org/en-US/docs/Glossary/TCP_slow_start)
- 这个过程重复进行，直到cwnd达到rwnd或者拥塞阈值（ssthresh）。[1](https://www.keycdn.com/support/tcp-slow-start) [2](https://developer.mozilla.org/en-US/docs/Glossary/TCP_slow_start)

### 拥塞避免

拥塞避免的过程是这样的：

- 当cwnd达到拥塞阈值（ssthresh）后，发送方进入拥塞避免阶段。[1](https://en.wikipedia.org/wiki/TCP_congestion_control) [2](https://www.geeksforgeeks.org/tcp-congestion-control/)
- 在拥塞避免阶段，发送方每收到一个确认包，就将cwnd增加1/cwnd的值，这样cwnd就以线性方式增长。[1](https://en.wikipedia.org/wiki/TCP_congestion_control) [2](https://www.geeksforgeeks.org/tcp-congestion-control/)
- 如果发送方没有收到确认包，或者收到重复的确认包，就认为网络发生了拥塞，就将ssthresh设为当前cwnd的一半，并进入拥塞检测阶段。[1](https://en.wikipedia.org/wiki/TCP_congestion_control) [2](https://www.geeksforgeeks.org/tcp-congestion-control/)

### 拥塞检测

拥塞检测的过程是这样的：

- 当发送方没有收到确认包，或者收到重复的确认包，就认为网络发生了拥塞，就将ssthresh设为当前cwnd的一半，并进入慢启动阶段或者快速恢复阶段。[1](https://en.wikipedia.org/wiki/TCP_congestion_control) [2](https://www.geeksforgeeks.org/tcp-congestion-control/)
- 在慢启动阶段，发送方将cwnd设为一个最大报文段大小（MSS），并重新开始指数增长。[1](https://en.wikipedia.org/wiki/TCP_congestion_control) [3](https://www.cs.umd.edu/users/suman/docs/711s97/node3.html)
- 在快速恢复阶段，发送方将cwnd设为ssthresh，并重新开始线性增长。[1](https://en.wikipedia.org/wiki/TCP_congestion_control) [2](https://www.geeksforgeeks.org/tcp-congestion-control/)

### ssthresh

ssthresh是TCP拥塞控制算法中的一个重要参数，它表示拥塞窗口大小（cwnd）的阈值，用于判断发送方应该使用慢启动算法还是拥塞避免算法。[1](https://www.geeksforgeeks.org/tcp-tahoe-and-tcp-reno/) [2](https://en.wikipedia.org/wiki/TCP_congestion_control)

ssthresh的作用是这样的：

- 当cwnd小于ssthresh时，发送方使用慢启动算法，即每收到一个确认包，就将cwnd加倍，这样cwnd就以指数方式增长。[1](https://www.geeksforgeeks.org/tcp-tahoe-and-tcp-reno/) [2](https://en.wikipedia.org/wiki/TCP_congestion_control)
- 当cwnd等于或大于ssthresh时，发送方使用拥塞避免算法，即每收到一个确认包，就将cwnd增加1/cwnd的值，这样cwnd就以线性方式增长。[1](https://www.geeksforgeeks.org/tcp-tahoe-and-tcp-reno/) [2](https://en.wikipedia.org/wiki/TCP_congestion_control)
- 当发送方检测到网络拥塞时，就将ssthresh设为当前cwnd的一半，并将cwnd设为一个最大报文段大小（MSS），然后重新开始慢启动或者快速恢复。[1](https://www.geeksforgeeks.org/tcp-tahoe-and-tcp-reno/) [3](https://www.geeksforgeeks.org/tcp-congestion-control/)