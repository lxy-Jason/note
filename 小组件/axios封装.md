```js
import axios from 'axios'
import { Message } from 'element-ui'

// 创建axios实例
const service = axios.create({
  baseURL: process.env.BASE_API, // api 的 base_url
  timeout: 50000 // 请求超时时间
})
// request拦截器
service.interceptors.request.use(
  (config) => {
    // TODO:等待修改
    return config
  },
  (error) => {
    // Do something with request error
    Promise.reject(error)
  }
)

// response 拦截器
service.interceptors.response.use(
  (response) => {
    // return response.data
    /**
     * code为非200是抛错 可结合自己业务进行修改
     */
    return response.data
  },
  (error) => {
    console.log('err' + error) // for debug
    Message({
      message: error.message,
      type: 'error',
      duration: 5 * 1000
    })
    return Promise.reject(error)
  }
)
export default service

```

错误直接拦截处理,不用在组件中再次处理,省不少事