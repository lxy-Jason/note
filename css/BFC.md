### 块级格式化上下文111

相当于一个隔离的容器,主要的作用就是将元素内部与元素外部分离

这样内外元素之间不会产生影响

### bfc的触发条件

- html本身是bfc
- float不是默认值
- overflow不是默认值
- position是absolute或者fixed
- display:inline-block,flex,其他的没记

### 具体应用场景

#### 外边距塌陷

同一个bfc的相邻的两个盒子的margin会重叠,称为外边距塌陷

开启bfc让两个盒子不属于同一个bfc下就可以解决这个问题

#### 清除内部浮动

内部盒子浮动之后,父盒子的高度为零

这是因为float会开启bfc,这样外部盒子文档流中相当于没有内容,高度为0

给父盒子也开启bfc,因为浮动元素在bfc中也会被计入高度

### 两列自适应

和清除浮动一个道理

左边float:left,定高定宽(可以不定宽)

右边overflow:hidden

左边float计入父盒子高度(前提是父盒子也是bfc)将高度撑起来

右边overflow开启另一个bfc,不会和float的元素重叠,且可以占满父盒子剩余空间

### 其他FC

FC指的是Formating Context(格式化上下文)

它是页面中的一块渲染区域,并且有一套渲染规则,它决定了其子元素将如何定位,以及和其他元素的关系和相互作用

### IFC

inline formating Context(内联格式化上下文)

**作用**

水平居中,当一个块要在环境中水平居中时,设置inline-block则会在外层产生IFC

通过text-align则可以使其水平居中

垂直居中,创建IFC,用其中一个元素撑开父元素的高度,然后设置其vertical-align:middle

其他行内元素则可以在此父元素下垂直居中

### GFC

GridLayout Formatting Context(网格布局格式化上下文)

当元素设置成display:grid的时候触发

### FFC

Flex Formating Context(自适应格式化上下文)

display:flex或者inline-flex时触发

