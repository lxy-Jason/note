- flex-direction 决定主轴方向
- flex-wrap 决定换行的方式
- justify-content 主轴上的对齐方式
- align-items 副轴上的对齐方式
- order 定义元素的排列顺序,数值越小，排列越靠前，默认为0。
- flex-grow 定义元素的放大比例,默认为0,即如果存在剩余空间也不会放大
- flex-shrink 定义了元素的缩小比例,默认为1,即如果空间不足,该元素将会缩小
- flex-basis 定义在分配多余空间之前,元素占据的主轴空间
- flex属性是`flex-grow,flex-shrink,flex-basis`三者的缩写形式
- align-self 允许元素于其他元素不一样的对齐方式,就是相当于覆盖`align-items`属性



1. `flex-grow`：表示Flex项的伸展比例，**默认值为0**。它决定了当Flex容器有剩余空间时，Flex项如何分配这些空间。如果所有的Flex项的`flex-grow`都为0，它们将不会伸展，剩余的空间将保持不使用。如果一个Flex项的`flex-grow`为1，而其他Flex项的`flex-grow`为0，那么这个Flex项将会占据所有的剩余空间。
2. `flex-shrink`：表示Flex项的收缩比例，**默认值为1**。它决定了当Flex容器的空间不足时，Flex项如何缩小。如果所有的Flex项的`flex-shrink`都为1，它们将以相同的比例缩小以适应空间。如果一个Flex项的`flex-shrink`为0，而其他Flex项的`flex-shrink`为1，那么这个Flex项将不会缩小。
3. `flex-basis`：表示Flex项的基准尺寸，**默认值为`auto`**。它决定了Flex项在分配空间之前的初始尺寸。可以使用像素值、百分比值或`auto`来设置`flex-basis`。例如，`flex-basis: 200px`表示Flex项的初始尺寸为200像素。



`flex`属性的缩写形式`flex: 1`等同于`flex: 1 1 0%`，即`flex-grow: 1`、`flex-shrink: 1`和`flex-basis: 0%`的简写形式。