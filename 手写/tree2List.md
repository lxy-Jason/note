### 树型结构转列表

```js
const data = [
    {
        id: 1,
        text: '节点1',
        parentId: 0,
        children: [
            {
                id: 2,
                text: '节点1_1',
                parentId: 1
            }
        ]
    }
]
```

```js
function treeToList(data){
  let res = [];
  const dfs = (tree) => {
    tree.forEach(item => {
      if(item.children){
        dfs(item.children)
        delete item.children
      }
      res.push(item)
    })
  }
  dfs(data)
  return res
};
```

