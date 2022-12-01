```js
let arr = [
  { id: 1, name: '部门1', pid: 0 }, //id是部门编号,pid是其上级部门的编号
  { id: 2, name: '部门2', pid: 1 },
  { id: 3, name: '部门3', pid: 1 },
  { id: 4, name: '部门4', pid: 3 },
  { id: 5, name: '部门5', pid: 4 },
  { id: 6, name: '部门6', pid: 0 },
]		
function list2Tree(arr){
  const list = [];
  arr.forEach(item => {
    const children = arr.filter(ele => {
      return item.id === ele.pid
    })
    if(children.length > 0){
      item.children = children;
    }
    if(item.pid === 0){ 
      list.push(item)
    }
  })
  return list
}
console.log(list2Tree(arr));
```

