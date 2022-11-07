### 现象

给子元素添加margin,结果导致父元素位置移动

```html
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
  <style>
    div{
      width: 100px;
      height: 100px;
    }
    .father{
      background-color: aqua;
      height: 200px;
    }
    .son{
      background-color: bisque;
      margin-top: 10px;
    }
  </style>
</head>

<body>
  <div class="father">
    <div class="son">2</div>
  </div>
</body>

</html>
```

### 触发条件

- 父子元素都是块级元素
- 只有margin-top和margin-bottom会出现这种情况
- 给子元素添加margin-top时,父子的上边界是重合的情况下
- margin-bottom时要求父元素高度为auto,或者说未指定

### 解决方法

重点在于打破上面的触发条件

- 把其中一个元素设置成inline-block
- 设置父元素padding: 1px
- 设置父元素border:1px

**为了避免margin重叠和穿透的麻烦可以记住**

**父子元素之间应当使用padding，兄弟元素之间应当使用margin**