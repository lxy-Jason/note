### 控制显示隐藏的方式不同

`v-show`是通过修改元素的`display`属性,dom元素依然存在

`v-if`是直接将元素添加或者删除

### 编译过程不同

`v-if`切换有一个局部的编译/卸载过程,切换过程中合适的销毁和重建内部的事件监听和子组件

`v-show`只是单纯的css改变

### 编译条件不同

`v-if`是真正的条件渲染,在条件为假时,不进行任何操作,只有条件为真了才会去渲染

当值被改变时,会触发对应的生命周期钩子

`v-show`不会触发生命周期钩子

**v-if有更高的切换消耗;v-show有更高的初始渲染消耗**