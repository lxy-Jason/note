```
{
  tag: 'DIV',
  attrs:{
  id:'app'
  },
  children: [
    {
      tag: 'SPAN',
      children: [
        { tag: 'A', children: [] }
      ]
    },
    {
      tag: 'SPAN',
      children: [
        { tag: 'A', children: [] },
        { tag: 'A', children: [] }
      ]
    }
  ]
}
把上诉虚拟Dom转化成下方真实Dom
<div id="app">
  <span>
    <a></a>
  </span>
  <span>
    <a></a>
    <a></a>
  </span>
</div>
```

```html
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
</head>

<body>
  <script>
    function render(vnode) {
      const { tag, attrs = {}, children } = vnode;
      //创建dom
      let el = document.createElement(tag);
      //添加attr
      for (const key in attrs) {
        el.setAttribute(key, attrs[key]);
      }
      //处理children
      if (Array.isArray(children) && children.length > 0) {
        children.forEach(child => el.appendChild(render(child)));//子元素添加在父元素中
      }
      return el
    }
    const vnode = {
      tag: 'DIV',
      attrs: {
        id: 'app'
      },
      children: [
        {
          tag: 'SPAN',
          children: [
            { tag: 'A', children: [] }
          ]
        },
        {
          tag: 'SPAN',
          children: [
            { tag: 'A', children: [] },
            { tag: 'A', children: [] }
          ]
        }
      ]
    }
    document.body.appendChild(render(vnode))
  </script>
</body>
</html>
```

**这个只是根据题目完成,相比实际转dom缺少很多内容**

