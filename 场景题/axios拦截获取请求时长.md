思路很简单

在请求拦截器中添加一个请求头,保存当前的时间戳

在响应拦截器中获取当前时间戳,减去请求头中的开始时间戳,得到的时间就是请求花费的时间

### 请求拦截器

```js
service.interceptors.request.use(
    config => {
        config.headers['request-startTime'] = new Date().getTime() //这里
        if (store.getters.token) {
            config.headers['token'] = getToken()
        }
        return config
    },
    error => {
        return Promise.reject(error)
    }
)

```

### 响应拦截器

```js
const start = response.config.headers['request-startTime']
const currentTime = new Date().getTime()
const requestDuration = ((currentTime - start)/1000).toFixed(2)

```

