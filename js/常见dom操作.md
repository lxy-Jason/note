### 创建节点

- createElement 创建新元素节点
- createTextNode 创建文本节点
- createDocumentFragement 创建文档碎片,主要用于临时存储节点,然后再一次性添加到dom中
- createArrtibute 创建属性节点

### 获取节点

- querySelector 获取第一个被传入的选择器选中的元素,没有返回`null`
- querySelectorAll 返回一个所有匹配上的dom的集合,是一个伪数组集合,没有匹配上返回空的伪数组
- getElementById 通过id进行匹配
- getElementByClassName 返回拥有指定`class`的dom集合,也是伪数组.

### 更新节点

- innerHTML 不仅可以修改文本内容,还能修改子元素的内容

- innerText和textContent 修改文本,且会对`HTML`编码,保证无法设置任何HTML标签

  区别:`innerText`不返回隐藏元素的文本,`textContent`返回所有文本

- style 修改css样式

### 添加节点

- appendChild 把一个子节点添加到父节点的最后一个子节点的后面
- insertBefore 把子节点插入到指定元素的前面
- setAttribute 给元素添加属性

### 删除节点

- removeChild,获取要删除元素的父元素用这个进行删除

