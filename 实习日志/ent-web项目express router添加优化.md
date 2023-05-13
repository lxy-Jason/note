之前router添加的方式过于重复

我们在添加的时候一般只需要修改几个固定的位置

其余的地方都是一样的

这次优化就是把相同的地方给封装起来了

```js
import { Router } from 'express'
let router = new Router()
export function addRouter(requestFn, path, apiList) {
  apiList.forEach(item => {
    router.post(`/${item}`, (req, res, next) => {
      requestFn(req)
        .post(path+item, req.body)
        .then(data => {
          res.json(data)
        })
        .catch(err => {
          next(err)
        })
    })
  })
  return router
}
```

```
 .post(path+item, req.body)
```

这里两个参数:

path:是`网关`=`qiye`加上接口文档中基本不变的那一部分=`/basicQuality/`

例如

```
const path = 'qiye/basicQuality/'
```

item是传入的接口名数组元素

```js
let apiList = [
  'oneEntType', //一企一档-创新成果-专利类型分布
    ...
]
```

接口文档拿到的是

```
/basicQuality/oneEntType
```

### 具体使用

在`src\routes\apis\jzzs`下创建新建文件

复制这段代码

```js
import { createBaseEnterpriseRequest } from '../../../../core/request/ms' //根据实际需求引入
import { addRouter } from '../../../../utils/addRouter' //注意两个导入的路径问题,这里无法用@
let apiList = [
 	//接口名称
    //...
]
const path = 'qiye/basicQuality/'  //路径中不变的部分

export default addRouter(createBaseEnterpriseRequest, path, apiList)
```



