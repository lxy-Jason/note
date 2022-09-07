less是css的预处理器

css预编译是对css的扩展,提供便捷的语法和特性供开发者编写源代码

less,sass等预处理器,最终还是会编译成css,浏览器只认识css

### 核心功能

#### 嵌套

最常用的功能,也是原生css一大痛点

#### 变量

将常用的值或者难记的值用变量保存,使用时可以使用变量,

比如使用的颜色

#### 运算

可以对属性值计算得到最终的值,

#### mixin

其实就是一堆预定义的样式的集合;我们可以把一些经常会出现的,一些固定写法抽出来集合在一块儿,然后使用的时候很方便的就可以调用了

```css
.MIX-center{ //这是一个经常用到的让元素内部水平垂直居中的东西;
    display:flex;
    align-items: center;
    justify-content: center;
}
div{
    .MIX-center;//亦可以写成.MIX-center();
}
```

这个就是相当于替代了一个类的作用

如果没有mixin这个东西,我们会新建一个类,给这个类添加这些属性,实现复用

---

但是mixin可以带**参数**,这是一个通用类做不到的

```css
.MIX-btn(@width,@height,@font-size,@color,@bdr-color){ //使用混合,把样式都写出来;
    width: @width;
    height: @height;
    font-size: @font-size;
    line-height:@height;
    text-align: center;
    border-radius: @height;
    color:@color;
    border:1px solid @bdr-color;
    text-decoration: none;
}
//然后,我们这样使用
button{
    .MIX-btn(100px,30px, 12px, #333,black);
    display: inline-block;
}

//实际编译得到
button{
    width: 100px;
    height: 30px;
    font-size: 12px;
    line-height: 30px;
    text-align: center;
    border-radius: 30px;
    color: #333;
    border: 1px solid black;
    text-decoration: none;
    display: inline-block;
}
```

#### 继承



#### @import 引入

