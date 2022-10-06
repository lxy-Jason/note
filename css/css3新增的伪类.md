### 常考

- nth-child(n)
- nth-of-type(n)

### 其他

- `:root` 选择文档根元素,就是html元素
- `:empty` 选择文本连个空格都没有的元素
- `:not` 否定选择器,用于排除
- `:only-child` 作为父元素中唯一的子元素时被选中

### 常考的区别

`p:nth-child(n)` 要求是p标签,同时是父元素的第n个子元素才能选中

`p:nth-of-type(n)`是在p标签的父元素中,选择第n个子元素,**第n个元素不需要是p标签**