router-api.js

每次新增express路由文件时,需要在这里加上一行

```
app.use()
```

这里细看其实基本上就是改了一个文件名

这些文件基本上位于一个文件夹下面

那么我获取这个文件夹下所有文件名,遍历执行app.use()

那以后就可以省略这一步了

获取文件夹下所有文件名,如果还有嵌套的文件夹,也会遍历获取

```js
import fs from 'fs'
import path from 'path'

export default function getfileName(folderPath) {
  folderPath = '../src/'+folderPath; //这里我也不知道为什么还需要一层src  实际的相对路径应该是 ../routes/apis/jzzs...
  // 递归遍历文件夹
  function traverseFolder(folderPath) {
    const files = fs.readdirSync(folderPath);
    const tree = [];

    files.forEach(file => {
      const filePath = path.join(folderPath, file);
      const stats = fs.statSync(filePath);

      if (stats.isDirectory()) {
        const subtree = traverseFolder(filePath);
        tree.push({
          name: file,
          type: 'folder',
          children: subtree,
        });
      } else {
        const fileName = path.parse(file).name;
        tree.push({
          name: fileName,
          type: 'file',
        });
      }
    });
    return tree;
  }
  return traverseFolder(folderPath);
}
```

根据文件名生成app.use()

```js
const jzzsPath = 'routes/apis/jzzs/enterprise-valuation' //这个路径得从src下的文件开始
function automaticUse(app) {
  const arr = getfileName(jzzsPath) //得到文件夹下的所有文件名
  arr.forEach(item => {
    if (item.type === 'folder') {
      item.children.forEach(child => { //这里只支持两层文件夹,看实际情况两层够用
        app.use(`/api/jzzs/${child.name}`, require(`./${jzzsPath}/${item.name}/${child.name}`))
      })
    } 
    else {
      app.use(`/api/jzzs/${item.name}`, require(`./${jzzsPath}/${item.name}`))
    }
  })
}
```

目前这里生效的是新一企一档相关的接口

我尝试过作用于jzzs下的所有文件

这里有三个文件,前后命名不统一

```js
  app.use('/api/jzzs/industrial-chain', require('./routes/apis/jzzs/index'))
  app.use('/api/jzzs/hotEnterprises', require('./routes/apis/jzzs/hot-enterprises'))
  app.use('/api/jzzs/supplyChain', require('./routes/apis/jzzs/supply-chain'))
```

我原本的想法是修改前者,但是这个会影响到services下面的api接口调用,要改的话得统一改

例如这个

```js
let insertCondition = (params, req) => {
  return createRequest(req).post('/api/jzzs/hotEnterprises/...', params)
}
```

所以我在尝试的时候是修改`routes/apis/jzzs`下的文件名

其实还是改前者会好一些,因为routers/apis下的文件和services/jzzs下的文件名是一一对应的,修改后者会导致文件名不一致

但是能跑,我这边本地测试是能跑通

因为作用在jzzs上影响范围比较大,所以我先在一企一档这里尝试一下

如果需要修改作用到jzzs

只需要修改路径为

```js
const jzzsPath = 'routes/apis/jzzs' //这个路径得从src下的文件开始
```

然后把我前面提到的三个文件命名设置一致

最后把所有使用jzzs文件夹下文件的app.use()语句注释掉就可以了

如果没有注释掉应该也能跑,但是应该会有一些不好的影响

