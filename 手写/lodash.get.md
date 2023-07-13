```js
function _get(obj,path,defaultValue="undefined"){
  //先将path处理成统一格式
  let newPath = [];
  if(Array.isArray(path)){
    newPath = path
  }
  else{
    // 字符串类型转换 obj[a]或者obj.a 转换成数组 这里把'['转成'.',']'转成''
    newPath = path.replace(/\[/g,'.').replace(/\]/g,'').split('.')
  }
  // obj 替换成obj.a逐步调用
  return newPath.reduce((o,key) => {
    return (o || {})[key];
  },obj) || defaultValue
}

var object = { 'a': [{ 'b': { 'c': 3 } }] };
 
console.log(_get(object, 'a[0].b.c'));;
// => 3
 
console.log(_get(object, ['a', '0', 'b', 'c']));;
// => 3
 
console.log(_get(object, 'a.b.c', 'default'));;
// => 'default'
```

